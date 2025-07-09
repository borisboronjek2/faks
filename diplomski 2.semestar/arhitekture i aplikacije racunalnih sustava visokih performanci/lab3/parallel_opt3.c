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
#define NUM_FRAMES 60

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
    #pragma omp parallel for collapse(2)
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
    #pragma omp parallel for collapse(2)
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            dst[i * WIDTH + j] = src[(i / 2) * SUB_WIDTH + (j / 2)];
        }
    }
}

int main() {
    double start_time = omp_get_wtime();

    FILE* input = fopen("raw_video.yuv", "rb");
    if (!input) {
        perror("Failed to open input file");
        return 1;
    }

    uint8_t** Y_all = malloc(NUM_FRAMES * sizeof(uint8_t*));
    uint8_t** U_all = malloc(NUM_FRAMES * sizeof(uint8_t*));
    uint8_t** V_all = malloc(NUM_FRAMES * sizeof(uint8_t*));
    uint8_t** U420_all = malloc(NUM_FRAMES * sizeof(uint8_t*));
    uint8_t** V420_all = malloc(NUM_FRAMES * sizeof(uint8_t*));
    uint8_t** Uup_all = malloc(NUM_FRAMES * sizeof(uint8_t*));
    uint8_t** Vup_all = malloc(NUM_FRAMES * sizeof(uint8_t*));

    #pragma omp parallel
    {
        #pragma omp single
        {
            for (int frame = 0; frame < NUM_FRAMES; frame++) {
                uint8_t* R = malloc(FRAME_SIZE);
                uint8_t* G = malloc(FRAME_SIZE);
                uint8_t* B = malloc(FRAME_SIZE);

                fread(R, 1, FRAME_SIZE, input);
                fread(G, 1, FRAME_SIZE, input);
                fread(B, 1, FRAME_SIZE, input);

                #pragma omp task firstprivate(frame, R, G, B)
                {
                    uint8_t* Y = malloc(FRAME_SIZE);
                    uint8_t* U = malloc(FRAME_SIZE);
                    uint8_t* V = malloc(FRAME_SIZE);
                    uint8_t* U_420 = malloc(SUB_SIZE);
                    uint8_t* V_420 = malloc(SUB_SIZE);
                    uint8_t* U_up = malloc(FRAME_SIZE);
                    uint8_t* V_up = malloc(FRAME_SIZE);

                    #pragma omp parallel for
                    for (int i = 0; i < FRAME_SIZE; i++) {
                        rgb_to_yuv(R[i], G[i], B[i], &Y[i], &U[i], &V[i]);
                    }

                    subsample_420(U, U_420);
                    subsample_420(V, V_420);
                    upsample_420(U_420, U_up);
                    upsample_420(V_420, V_up);

                    Y_all[frame] = Y;
                    U_all[frame] = U;
                    V_all[frame] = V;
                    U420_all[frame] = U_420;
                    V420_all[frame] = V_420;
                    Uup_all[frame] = U_up;
                    Vup_all[frame] = V_up;

                    free(R); free(G); free(B);
                }
            }
        }
    }

    fclose(input);

    FILE* out_yuv444 = fopen("rgb2yuv.yuv", "wb");
    FILE* out_yuv420 = fopen("subsampled.yuv", "wb");
    FILE* out_upsampled = fopen("upsampled.yuv", "wb");

    if (!out_yuv444 || !out_yuv420 || !out_upsampled) {
        perror("Failed to open output file(s)");
        return 1;
    }

    for (int frame = 0; frame < NUM_FRAMES; frame++) {
        fwrite(Y_all[frame], 1, FRAME_SIZE, out_yuv444);
        fwrite(U_all[frame], 1, FRAME_SIZE, out_yuv444);
        fwrite(V_all[frame], 1, FRAME_SIZE, out_yuv444);

        fwrite(Y_all[frame], 1, FRAME_SIZE, out_yuv420);
        fwrite(U420_all[frame], 1, SUB_SIZE, out_yuv420);
        fwrite(V420_all[frame], 1, SUB_SIZE, out_yuv420);

        fwrite(Y_all[frame], 1, FRAME_SIZE, out_upsampled);
        fwrite(Uup_all[frame], 1, FRAME_SIZE, out_upsampled);
        fwrite(Vup_all[frame], 1, FRAME_SIZE, out_upsampled);

        free(Y_all[frame]); free(U_all[frame]); free(V_all[frame]);
        free(U420_all[frame]); free(V420_all[frame]);
        free(Uup_all[frame]); free(Vup_all[frame]);
    }

    fclose(out_yuv444);
    fclose(out_yuv420);
    fclose(out_upsampled);

    free(Y_all); free(U_all); free(V_all);
    free(U420_all); free(V420_all);
    free(Uup_all); free(Vup_all);

    double end_time = omp_get_wtime();
    printf("Kod se izvodio %.6f sekundi\n", end_time - start_time);

    return 0;
}