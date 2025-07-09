#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <omp.h>

#define WIDTH 3840
#define HEIGHT 2160
#define FRAME_SIZE (WIDTH * HEIGHT)
#define SUB_WIDTH (WIDTH / 2)
#define SUB_HEIGHT (HEIGHT / 2)
#define SUB_SIZE (SUB_WIDTH * SUB_HEIGHT)

// RGB → YUV pretvorba
void rgb_to_yuv(uint8_t r, uint8_t g, uint8_t b, uint8_t* y, uint8_t* u, uint8_t* v) {
    float yf = 0.257f * r + 0.504f * g + 0.098f * b + 16;
    float uf = -0.148f * r - 0.291f * g + 0.439f * b + 128;
    float vf = 0.439f * r - 0.368f * g - 0.071f * b + 128;

    *y = (uint8_t)(yf < 0 ? 0 : (yf > 255 ? 255 : yf));
    *u = (uint8_t)(uf < 0 ? 0 : (uf > 255 ? 255 : uf));
    *v = (uint8_t)(vf < 0 ? 0 : (vf > 255 ? 255 : vf));
}

// Poduzorkovanje (4:4:4 → 4:2:0)
void subsample_420(uint8_t* src, uint8_t* dst) {
    for (int i = 0; i < HEIGHT; i += 2) {
        for (int j = 0; j < WIDTH; j += 2) {
            int idx1 = i * WIDTH + j;
            int idx2 = (i + 1) * WIDTH + j;
            int idx3 = i * WIDTH + j + 1;
            int idx4 = (i + 1) * WIDTH + j + 1;

            int sum = src[idx1] + src[idx2] + src[idx3] + src[idx4];
            dst[(i / 2) * SUB_WIDTH + (j / 2)] = sum / 4;
        }
    }
}

// Naduzorkovanje (4:2:0 → 4:4:4) – najbliži susjed
void upsample_420(uint8_t* src, uint8_t* dst) {
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            dst[i * WIDTH + j] = src[(i / 2) * SUB_WIDTH + (j / 2)];
        }
    }
}

int main() {
    double start_time = omp_get_wtime();

    FILE* input = fopen("raw_video.yuv", "rb");
    FILE* out_yuv444 = fopen("rgb2yuv.yuv", "wb");
    FILE* out_yuv420 = fopen("subsampled.yuv", "wb");
    FILE* out_upsampled = fopen("upsampled.yuv", "wb");

    if (!input || !out_yuv444 || !out_yuv420 || !out_upsampled) {
        perror("Failed to open file");
        return 1;
    }

    uint8_t* R = malloc(FRAME_SIZE);
    uint8_t* G = malloc(FRAME_SIZE);
    uint8_t* B = malloc(FRAME_SIZE);
    uint8_t* Y = malloc(FRAME_SIZE);
    uint8_t* U = malloc(FRAME_SIZE);
    uint8_t* V = malloc(FRAME_SIZE);
    uint8_t* U_420 = malloc(SUB_SIZE);
    uint8_t* V_420 = malloc(SUB_SIZE);
    uint8_t* U_up = malloc(FRAME_SIZE);
    uint8_t* V_up = malloc(FRAME_SIZE);

    if (!R || !G || !B || !Y || !U || !V || !U_420 || !V_420 || !U_up || !V_up) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    for (int frame = 0; frame < 60; frame++) {
        fread(R, 1, FRAME_SIZE, input);
        fread(G, 1, FRAME_SIZE, input);
        fread(B, 1, FRAME_SIZE, input);

        for (int i = 0; i < FRAME_SIZE; i++) {
            rgb_to_yuv(R[i], G[i], B[i], &Y[i], &U[i], &V[i]);
        }

        // yuv444p spremanje
        fwrite(Y, 1, FRAME_SIZE, out_yuv444);
        fwrite(U, 1, FRAME_SIZE, out_yuv444);
        fwrite(V, 1, FRAME_SIZE, out_yuv444);

        // poduzorkovanje
        subsample_420(U, U_420);
        subsample_420(V, V_420);

        // yuv420p spremanje
        fwrite(Y, 1, FRAME_SIZE, out_yuv420);
        fwrite(U_420, 1, SUB_SIZE, out_yuv420);
        fwrite(V_420, 1, SUB_SIZE, out_yuv420);

        // naduzorkovanje
        upsample_420(U_420, U_up);
        upsample_420(V_420, V_up);

        // yuv444p spremanje (naduzorkovan)
        fwrite(Y, 1, FRAME_SIZE, out_upsampled);
        fwrite(U_up, 1, FRAME_SIZE, out_upsampled);
        fwrite(V_up, 1, FRAME_SIZE, out_upsampled);
    }

    free(R); free(G); free(B);
    free(Y); free(U); free(V);
    free(U_420); free(V_420);
    free(U_up); free(V_up);
    fclose(input);
    fclose(out_yuv444);
    fclose(out_yuv420);
    fclose(out_upsampled);

    double end_time = omp_get_wtime();

    printf("Kod se izvodio %.6f sekundi\n", end_time - start_time);

    return 0;
}
