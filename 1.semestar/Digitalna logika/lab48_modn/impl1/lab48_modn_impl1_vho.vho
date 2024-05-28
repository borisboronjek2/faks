
-- VHDL netlist produced by program ldbanno, Version Diamond (64-bit) 3.11.0.396.4

-- ldbanno -n VHDL -o lab48_modn_impl1_vho.vho -w -neg -gui lab48_modn_impl1.ncd 
-- Netlist created on Thu Dec 10 21:26:09 2020
-- Netlist written on Thu Dec 10 21:26:28 2020
-- Design is for device LFXP2-8E
-- Design is for package TQFP144
-- Design is for performance grade 5

-- entity ec2iobuf
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity ec2iobuf is
    port (I: in Std_logic; PAD: out Std_logic);

    ATTRIBUTE Vital_Level0 OF ec2iobuf : ENTITY IS TRUE;

  end ec2iobuf;

  architecture Structure of ec2iobuf is
    component OB
      port (I: in Std_logic; O: out Std_logic);
    end component;
  begin
    INST5: OB
      port map (I=>I, O=>PAD);
  end Structure;

-- entity led_0_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_0_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_0_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led0	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led0: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_0_B : ENTITY IS TRUE;

  end led_0_B;

  architecture Structure of led_0_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led0_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_0: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led0_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led0_out)
    VARIABLE led0_zd         	: std_logic := 'X';
    VARIABLE led0_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led0_zd 	:= led0_out;

    VitalPathDelay01Z (
      OutSignal => led0, OutSignalName => "led0", OutTemp => led0_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led0,
                           PathCondition => TRUE)),
      GlitchData => led0_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity ec2iobuf0001
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity ec2iobuf0001 is
    port (Z: out Std_logic; PAD: in Std_logic);

    ATTRIBUTE Vital_Level0 OF ec2iobuf0001 : ENTITY IS TRUE;

  end ec2iobuf0001;

  architecture Structure of ec2iobuf0001 is
    component IB
      port (I: in Std_logic; O: out Std_logic);
    end component;
  begin
    INST1: IB
      port map (I=>PAD, O=>Z);
  end Structure;

-- entity clk_25mB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity clk_25mB is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "clk_25mB";

      tipd_clk25m  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_clk25m_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_clk25m 	: VitalDelayType := 0 ns;
      tpw_clk25m_posedge	: VitalDelayType := 0 ns;
      tpw_clk25m_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; clk25m: in Std_logic);

    ATTRIBUTE Vital_Level0 OF clk_25mB : ENTITY IS TRUE;

  end clk_25mB;

  architecture Structure of clk_25mB is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal clk25m_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    clk_25m_pad: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>clk25m_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(clk25m_ipd, clk25m, tipd_clk25m);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, clk25m_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_clk25m_clk25m          	: x01 := '0';
    VARIABLE periodcheckinfo_clk25m	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => clk25m_ipd,
        TestSignalName => "clk25m",
        Period => tperiod_clk25m,
        PulseWidthHigh => tpw_clk25m_posedge,
        PulseWidthLow => tpw_clk25m_negedge,
        PeriodData => periodcheckinfo_clk25m,
        Violation => tviol_clk25m_clk25m,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => clk25m_ipd'last_event,
                           PathDelay => tpd_clk25m_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity led_7_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_7_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_7_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led7	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led7: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_7_B : ENTITY IS TRUE;

  end led_7_B;

  architecture Structure of led_7_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led7_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_7: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led7_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led7_out)
    VARIABLE led7_zd         	: std_logic := 'X';
    VARIABLE led7_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led7_zd 	:= led7_out;

    VitalPathDelay01Z (
      OutSignal => led7, OutSignalName => "led7", OutTemp => led7_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led7,
                           PathCondition => TRUE)),
      GlitchData => led7_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity led_6_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_6_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_6_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led6	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led6: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_6_B : ENTITY IS TRUE;

  end led_6_B;

  architecture Structure of led_6_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led6_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_6: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led6_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led6_out)
    VARIABLE led6_zd         	: std_logic := 'X';
    VARIABLE led6_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led6_zd 	:= led6_out;

    VitalPathDelay01Z (
      OutSignal => led6, OutSignalName => "led6", OutTemp => led6_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led6,
                           PathCondition => TRUE)),
      GlitchData => led6_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity led_5_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_5_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_5_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led5	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led5: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_5_B : ENTITY IS TRUE;

  end led_5_B;

  architecture Structure of led_5_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led5_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_5: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led5_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led5_out)
    VARIABLE led5_zd         	: std_logic := 'X';
    VARIABLE led5_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led5_zd 	:= led5_out;

    VitalPathDelay01Z (
      OutSignal => led5, OutSignalName => "led5", OutTemp => led5_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led5,
                           PathCondition => TRUE)),
      GlitchData => led5_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity led_4_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_4_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_4_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led4	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led4: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_4_B : ENTITY IS TRUE;

  end led_4_B;

  architecture Structure of led_4_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led4_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_4: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led4_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led4_out)
    VARIABLE led4_zd         	: std_logic := 'X';
    VARIABLE led4_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led4_zd 	:= led4_out;

    VitalPathDelay01Z (
      OutSignal => led4, OutSignalName => "led4", OutTemp => led4_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led4,
                           PathCondition => TRUE)),
      GlitchData => led4_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity led_3_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_3_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_3_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led3	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led3: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_3_B : ENTITY IS TRUE;

  end led_3_B;

  architecture Structure of led_3_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led3_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_3: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led3_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led3_out)
    VARIABLE led3_zd         	: std_logic := 'X';
    VARIABLE led3_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led3_zd 	:= led3_out;

    VitalPathDelay01Z (
      OutSignal => led3, OutSignalName => "led3", OutTemp => led3_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led3,
                           PathCondition => TRUE)),
      GlitchData => led3_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity led_2_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_2_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_2_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led2	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led2: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_2_B : ENTITY IS TRUE;

  end led_2_B;

  architecture Structure of led_2_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led2_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_2: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led2_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led2_out)
    VARIABLE led2_zd         	: std_logic := 'X';
    VARIABLE led2_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led2_zd 	:= led2_out;

    VitalPathDelay01Z (
      OutSignal => led2, OutSignalName => "led2", OutTemp => led2_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led2,
                           PathCondition => TRUE)),
      GlitchData => led2_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity led_1_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity led_1_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "led_1_B";

      tipd_PADDO  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_PADDO_led1	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (PADDO: in Std_logic; led1: out Std_logic);

    ATTRIBUTE Vital_Level0 OF led_1_B : ENTITY IS TRUE;

  end led_1_B;

  architecture Structure of led_1_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDO_ipd 	: std_logic := 'X';
    signal led1_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    led_pad_1: ec2iobuf
      port map (I=>PADDO_ipd, PAD=>led1_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(PADDO_ipd, PADDO, tipd_PADDO);
    END BLOCK;

    VitalBehavior : PROCESS (PADDO_ipd, led1_out)
    VARIABLE led1_zd         	: std_logic := 'X';
    VARIABLE led1_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    led1_zd 	:= led1_out;

    VitalPathDelay01Z (
      OutSignal => led1, OutSignalName => "led1", OutTemp => led1_zd,
      Paths      => (0 => (InputChangeTime => PADDO_ipd'last_event,
                           PathDelay => tpd_PADDO_led1,
                           PathCondition => TRUE)),
      GlitchData => led1_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity ec2iobuf0002
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity ec2iobuf0002 is
    port (Z: out Std_logic; PAD: in Std_logic);

    ATTRIBUTE Vital_Level0 OF ec2iobuf0002 : ENTITY IS TRUE;

  end ec2iobuf0002;

  architecture Structure of ec2iobuf0002 is
    component IBPD
      port (I: in Std_logic; O: out Std_logic);
    end component;
  begin
    INST1: IBPD
      port map (I=>PAD, O=>Z);
  end Structure;

-- entity btn_rightB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity btn_rightB is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "btn_rightB";

      tipd_btnright  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_btnright_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_btnright 	: VitalDelayType := 0 ns;
      tpw_btnright_posedge	: VitalDelayType := 0 ns;
      tpw_btnright_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; btnright: in Std_logic);

    ATTRIBUTE Vital_Level0 OF btn_rightB : ENTITY IS TRUE;

  end btn_rightB;

  architecture Structure of btn_rightB is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal btnright_ipd 	: std_logic := 'X';

    component ec2iobuf0002
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    btn_right_pad: ec2iobuf0002
      port map (Z=>PADDI_out, PAD=>btnright_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(btnright_ipd, btnright, tipd_btnright);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, btnright_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_btnright_btnright          	: x01 := '0';
    VARIABLE periodcheckinfo_btnright	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => btnright_ipd,
        TestSignalName => "btnright",
        Period => tperiod_btnright,
        PulseWidthHigh => tpw_btnright_posedge,
        PulseWidthLow => tpw_btnright_negedge,
        PeriodData => periodcheckinfo_btnright,
        Violation => tviol_btnright_btnright,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => btnright_ipd'last_event,
                           PathDelay => tpd_btnright_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity btn_upB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity btn_upB is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "btn_upB";

      tipd_btnup  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_btnup_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_btnup 	: VitalDelayType := 0 ns;
      tpw_btnup_posedge	: VitalDelayType := 0 ns;
      tpw_btnup_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; btnup: in Std_logic);

    ATTRIBUTE Vital_Level0 OF btn_upB : ENTITY IS TRUE;

  end btn_upB;

  architecture Structure of btn_upB is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal btnup_ipd 	: std_logic := 'X';

    component ec2iobuf0002
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    btn_up_pad: ec2iobuf0002
      port map (Z=>PADDI_out, PAD=>btnup_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(btnup_ipd, btnup, tipd_btnup);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, btnup_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_btnup_btnup          	: x01 := '0';
    VARIABLE periodcheckinfo_btnup	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => btnup_ipd,
        TestSignalName => "btnup",
        Period => tperiod_btnup,
        PulseWidthHigh => tpw_btnup_posedge,
        PulseWidthLow => tpw_btnup_negedge,
        PeriodData => periodcheckinfo_btnup,
        Violation => tviol_btnup_btnup,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => btnup_ipd'last_event,
                           PathDelay => tpd_btnup_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity smuxlregsre
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity smuxlregsre is
    port (D0: in Std_logic; SP: in Std_logic; CK: in Std_logic; 
          LSR: in Std_logic; Q: out Std_logic);

    ATTRIBUTE Vital_Level0 OF smuxlregsre : ENTITY IS TRUE;

  end smuxlregsre;

  architecture Structure of smuxlregsre is
    component IFS1P3DX
      generic (GSR: String);
      port (D: in Std_logic; SP: in Std_logic; SCLK: in Std_logic; 
            CD: in Std_logic; Q: out Std_logic);
    end component;
  begin
    INST01: IFS1P3DX
      generic map (GSR => "DISABLED")
      port map (D=>D0, SP=>SP, SCLK=>CK, CD=>LSR, Q=>Q);
  end Structure;

-- entity vccB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity vccB is
    port (PWR1: out Std_logic);

    ATTRIBUTE Vital_Level0 OF vccB : ENTITY IS TRUE;

  end vccB;

  architecture Structure of vccB is
    component VHI
      port (Z: out Std_logic);
    end component;
  begin
    INST1: VHI
      port map (Z=>PWR1);
  end Structure;

-- entity gnd
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity gnd is
    port (PWR0: out Std_logic);

    ATTRIBUTE Vital_Level0 OF gnd : ENTITY IS TRUE;

  end gnd;

  architecture Structure of gnd is
    component VLO
      port (Z: out Std_logic);
    end component;
  begin
    INST1: VLO
      port map (Z=>PWR0);
  end Structure;

-- entity btn_up_MGIOL
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity btn_up_MGIOL is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "btn_up_MGIOL";

      tipd_DI  	: VitalDelayType01 := (0 ns, 0 ns);
      tipd_CLK  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_CLK_INFF	 : VitalDelayType01 := (0 ns, 0 ns);
      ticd_CLK	: VitalDelayType := 0 ns;
      tisd_DI_CLK	: VitalDelayType := 0 ns;
      tsetup_DI_CLK_noedge_posedge	: VitalDelayType := 0 ns;
      thold_DI_CLK_noedge_posedge	: VitalDelayType := 0 ns);

    port (DI: in Std_logic; CLK: in Std_logic; INFF: out Std_logic);

    ATTRIBUTE Vital_Level0 OF btn_up_MGIOL : ENTITY IS TRUE;

  end btn_up_MGIOL;

  architecture Structure of btn_up_MGIOL is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal DI_ipd 	: std_logic := 'X';
    signal DI_dly 	: std_logic := 'X';
    signal CLK_ipd 	: std_logic := 'X';
    signal CLK_dly 	: std_logic := 'X';
    signal INFF_out 	: std_logic := 'X';

    signal VCCI: Std_logic;
    signal GNDI: Std_logic;
    component gnd
      port (PWR0: out Std_logic);
    end component;
    component smuxlregsre
      port (D0: in Std_logic; SP: in Std_logic; CK: in Std_logic; 
            LSR: in Std_logic; Q: out Std_logic);
    end component;
    component vccB
      port (PWR1: out Std_logic);
    end component;
  begin
    I_debouncer_R_key_syncio: smuxlregsre
      port map (D0=>DI_dly, SP=>VCCI, CK=>CLK_dly, LSR=>GNDI, Q=>INFF_out);
    DRIVEVCC: vccB
      port map (PWR1=>VCCI);
    DRIVEGND: gnd
      port map (PWR0=>GNDI);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(DI_ipd, DI, tipd_DI);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(DI_dly, DI_ipd, tisd_DI_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
    END BLOCK;

    VitalBehavior : PROCESS (DI_dly, CLK_dly, INFF_out)
    VARIABLE INFF_zd         	: std_logic := 'X';
    VARIABLE INFF_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_DI_CLK       	: x01 := '0';
    VARIABLE DI_CLK_TimingDatash	: VitalTimingDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => DI_dly,
        TestSignalName => "DI",
        TestDelay => tisd_DI_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_DI_CLK_noedge_posedge,
        SetupLow => tsetup_DI_CLK_noedge_posedge,
        HoldHigh => thold_DI_CLK_noedge_posedge,
        HoldLow => thold_DI_CLK_noedge_posedge,
        CheckEnabled => TRUE,
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => DI_CLK_TimingDatash,
        Violation => tviol_DI_CLK,
        MsgSeverity => warning);

    END IF;

    INFF_zd 	:= INFF_out;

    VitalPathDelay01 (
      OutSignal => INFF, OutSignalName => "INFF", OutTemp => INFF_zd,
      Paths      => (0 => (InputChangeTime => CLK_dly'last_event,
                           PathDelay => tpd_CLK_INFF,
                           PathCondition => TRUE)),
      GlitchData => INFF_GlitchData,
      Mode       => ondetect, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity count
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity count is
    port (clk_25m: in Std_logic; btn_up: in Std_logic; btn_right: in Std_logic; 
          led: out Std_logic_vector (7 downto 0));



  end count;

  architecture Structure of count is
    signal led_c_0: Std_logic;
    signal VCC: Std_logic;
    signal un7_r_cry_0: Std_logic;
    signal I_debouncer_VCC: Std_logic;
    signal I_debouncer_R_debounce_cnt_31: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_1: Std_logic;
    signal I_debouncer_r_debounce_cnt12_i: Std_logic;
    signal clk_25m_c: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_30: Std_logic;
    signal I_debouncer_R_debounce_cnt_30: Std_logic;
    signal I_debouncer_R_debounce_cnt_29: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_2: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_3: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_28: Std_logic;
    signal I_debouncer_R_debounce_cnt_28: Std_logic;
    signal I_debouncer_R_debounce_cnt_27: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_4: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_5: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_26: Std_logic;
    signal I_debouncer_R_debounce_cnt_26: Std_logic;
    signal I_debouncer_R_debounce_cnt_25: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_6: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_7: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_24: Std_logic;
    signal I_debouncer_R_debounce_cnt_24: Std_logic;
    signal I_debouncer_R_debounce_cnt_23: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_8: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_9: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_22: Std_logic;
    signal I_debouncer_R_debounce_cnt_22: Std_logic;
    signal I_debouncer_R_debounce_cnt_21: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_10: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_11: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_20: Std_logic;
    signal I_debouncer_R_debounce_cnt_20: Std_logic;
    signal I_debouncer_R_debounce_cnt_19: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_12: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_13: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_18: Std_logic;
    signal I_debouncer_R_debounce_cnt_18: Std_logic;
    signal I_debouncer_R_debounce_cnt_17: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_14: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_15: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_16: Std_logic;
    signal I_debouncer_R_debounce_cnt_16: Std_logic;
    signal I_debouncer_R_debounce_cnt_15: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_16: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_17: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_14: Std_logic;
    signal I_debouncer_R_debounce_cnt_14: Std_logic;
    signal I_debouncer_R_debounce_cnt_13: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_18: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_19: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_12: Std_logic;
    signal I_debouncer_R_debounce_cnt_12: Std_logic;
    signal I_debouncer_R_debounce_cnt_11: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_20: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_21: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_10: Std_logic;
    signal I_debouncer_R_debounce_cnt_10: Std_logic;
    signal I_debouncer_R_debounce_cnt_9: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_22: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_23: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_8: Std_logic;
    signal I_debouncer_R_debounce_cnt_8: Std_logic;
    signal I_debouncer_R_debounce_cnt_7: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_24: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_25: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_6: Std_logic;
    signal I_debouncer_R_debounce_cnt_6: Std_logic;
    signal I_debouncer_R_debounce_cnt_5: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_26: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_27: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_4: Std_logic;
    signal I_debouncer_R_debounce_cnt_4: Std_logic;
    signal I_debouncer_R_debounce_cnt_3: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_28: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_29: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_2: Std_logic;
    signal I_debouncer_R_debounce_cnt_2: Std_logic;
    signal I_debouncer_R_debounce_cnt_1: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_30: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_31: Std_logic;
    signal I_debouncer_un1_r_debounce_cnt_cry_0: Std_logic;
    signal I_debouncer_R_debounce_cnt_0: Std_logic;
    signal led_c_7: Std_logic;
    signal un7_r_s_7_0_S0: Std_logic;
    signal btn_right_c: Std_logic;
    signal clk_key: Std_logic;
    signal un7_r_cry_6: Std_logic;
    signal led_c_6: Std_logic;
    signal led_c_5: Std_logic;
    signal un7_r_cry_5_0_S0: Std_logic;
    signal un7_r_cry_4: Std_logic;
    signal un7_r_cry_5_0_S1: Std_logic;
    signal led_c_4: Std_logic;
    signal led_c_3: Std_logic;
    signal un7_r_cry_3_0_S1: Std_logic;
    signal un7_r_cry_2: Std_logic;
    signal un7_r_cry_3_0_S0: Std_logic;
    signal led_c_2: Std_logic;
    signal led_c_1: Std_logic;
    signal un7_r_cry_1_0_S1: Std_logic;
    signal un7_r_cry_1_0_S0: Std_logic;
    signal I_debouncer_R_debounce_cnt_i_0: Std_logic;
    signal un2_r_5: Std_logic;
    signal un2_r_4: Std_logic;
    signal Rc_1: Std_logic;
    signal led_c_i_0: Std_logic;
    signal Rc_0: Std_logic;
    signal Rc: Std_logic;
    signal I_debouncer_R_key_sync: Std_logic;
    signal I_debouncer_R_key_last_0_sqmuxa: Std_logic;
    signal btn_up_c: Std_logic;
    signal VCCI: Std_logic;
    component VHI
      port (Z: out Std_logic);
    end component;
    component PUR
      port (PUR: in Std_logic);
    end component;
    component GSR
      port (GSR: in Std_logic);
    end component;
    component led_0_B
      port (PADDO: in Std_logic; led0: out Std_logic);
    end component;
    component clk_25mB
      port (PADDI: out Std_logic; clk25m: in Std_logic);
    end component;
    component led_7_B
      port (PADDO: in Std_logic; led7: out Std_logic);
    end component;
    component led_6_B
      port (PADDO: in Std_logic; led6: out Std_logic);
    end component;
    component led_5_B
      port (PADDO: in Std_logic; led5: out Std_logic);
    end component;
    component led_4_B
      port (PADDO: in Std_logic; led4: out Std_logic);
    end component;
    component led_3_B
      port (PADDO: in Std_logic; led3: out Std_logic);
    end component;
    component led_2_B
      port (PADDO: in Std_logic; led2: out Std_logic);
    end component;
    component led_1_B
      port (PADDO: in Std_logic; led1: out Std_logic);
    end component;
    component btn_rightB
      port (PADDI: out Std_logic; btnright: in Std_logic);
    end component;
    component btn_upB
      port (PADDI: out Std_logic; btnup: in Std_logic);
    end component;
    component btn_up_MGIOL
      port (DI: in Std_logic; CLK: in Std_logic; INFF: out Std_logic);
    end component;
  begin
    SLICE_0I: SCCU2B
      generic map (CCU2_INJECT1_0=>"NO", INIT0_INITVAL=>"0x00FF", 
                   INIT1_INITVAL=>"0xCCCC")
      port map (M1=>'X', A1=>'X', B1=>led_c_0, C1=>'X', D1=>'X', DI1=>'X', 
                DI0=>'X', A0=>'X', B0=>'X', C0=>'X', D0=>VCC, FCI=>'X', 
                M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', FCO=>un7_r_cry_0, 
                F1=>open, Q1=>open, F0=>open, Q0=>open);
    I_debouncer_SLICE_1I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x3300", INIT1_INITVAL=>"0x0000", 
                   REG0_SD=>"VHI", CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>'X', C1=>'X', D1=>'X', DI1=>'X', 
                DI0=>I_debouncer_un1_r_debounce_cnt_1, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_31, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_30, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, FCO=>open, 
                F1=>open, Q1=>open, F0=>I_debouncer_un1_r_debounce_cnt_1, 
                Q0=>I_debouncer_R_debounce_cnt_31);
    I_debouncer_SLICE_2I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33FF", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_30, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_2, 
                DI0=>I_debouncer_un1_r_debounce_cnt_3, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_29, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_28, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_30, 
                F1=>I_debouncer_un1_r_debounce_cnt_2, 
                Q1=>I_debouncer_R_debounce_cnt_30, 
                F0=>I_debouncer_un1_r_debounce_cnt_3, 
                Q0=>I_debouncer_R_debounce_cnt_29);
    I_debouncer_SLICE_3I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_28, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_4, 
                DI0=>I_debouncer_un1_r_debounce_cnt_5, 
                A0=>I_debouncer_R_debounce_cnt_27, B0=>'X', C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_26, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_28, 
                F1=>I_debouncer_un1_r_debounce_cnt_4, 
                Q1=>I_debouncer_R_debounce_cnt_28, 
                F0=>I_debouncer_un1_r_debounce_cnt_5, 
                Q0=>I_debouncer_R_debounce_cnt_27);
    I_debouncer_SLICE_4I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_26, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_6, 
                DI0=>I_debouncer_un1_r_debounce_cnt_7, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_25, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_24, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_26, 
                F1=>I_debouncer_un1_r_debounce_cnt_6, 
                Q1=>I_debouncer_R_debounce_cnt_26, 
                F0=>I_debouncer_un1_r_debounce_cnt_7, 
                Q0=>I_debouncer_R_debounce_cnt_25);
    I_debouncer_SLICE_5I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_24, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_8, 
                DI0=>I_debouncer_un1_r_debounce_cnt_9, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_23, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_22, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_24, 
                F1=>I_debouncer_un1_r_debounce_cnt_8, 
                Q1=>I_debouncer_R_debounce_cnt_24, 
                F0=>I_debouncer_un1_r_debounce_cnt_9, 
                Q0=>I_debouncer_R_debounce_cnt_23);
    I_debouncer_SLICE_6I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_22, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_10, 
                DI0=>I_debouncer_un1_r_debounce_cnt_11, 
                A0=>I_debouncer_R_debounce_cnt_21, B0=>'X', C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_20, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_22, 
                F1=>I_debouncer_un1_r_debounce_cnt_10, 
                Q1=>I_debouncer_R_debounce_cnt_22, 
                F0=>I_debouncer_un1_r_debounce_cnt_11, 
                Q0=>I_debouncer_R_debounce_cnt_21);
    I_debouncer_SLICE_7I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_20, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_12, 
                DI0=>I_debouncer_un1_r_debounce_cnt_13, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_19, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_18, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_20, 
                F1=>I_debouncer_un1_r_debounce_cnt_12, 
                Q1=>I_debouncer_R_debounce_cnt_20, 
                F0=>I_debouncer_un1_r_debounce_cnt_13, 
                Q0=>I_debouncer_R_debounce_cnt_19);
    I_debouncer_SLICE_8I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG0_REGSET=>"SET", REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_18, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_14, 
                DI0=>I_debouncer_un1_r_debounce_cnt_15, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_17, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_16, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_18, 
                F1=>I_debouncer_un1_r_debounce_cnt_14, 
                Q1=>I_debouncer_R_debounce_cnt_18, 
                F0=>I_debouncer_un1_r_debounce_cnt_15, 
                Q0=>I_debouncer_R_debounce_cnt_17);
    I_debouncer_SLICE_9I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG0_REGSET=>"SET", REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_16, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_16, 
                DI0=>I_debouncer_un1_r_debounce_cnt_17, 
                A0=>I_debouncer_R_debounce_cnt_15, B0=>'X', C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_14, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_16, 
                F1=>I_debouncer_un1_r_debounce_cnt_16, 
                Q1=>I_debouncer_R_debounce_cnt_16, 
                F0=>I_debouncer_un1_r_debounce_cnt_17, 
                Q0=>I_debouncer_R_debounce_cnt_15);
    I_debouncer_SLICE_10I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG0_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_14, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_18, 
                DI0=>I_debouncer_un1_r_debounce_cnt_19, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_13, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_12, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_14, 
                F1=>I_debouncer_un1_r_debounce_cnt_18, 
                Q1=>I_debouncer_R_debounce_cnt_14, 
                F0=>I_debouncer_un1_r_debounce_cnt_19, 
                Q0=>I_debouncer_R_debounce_cnt_13);
    I_debouncer_SLICE_11I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_12, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_20, 
                DI0=>I_debouncer_un1_r_debounce_cnt_21, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_11, C0=>'X', 
                D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_10, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_12, 
                F1=>I_debouncer_un1_r_debounce_cnt_20, 
                Q1=>I_debouncer_R_debounce_cnt_12, 
                F0=>I_debouncer_un1_r_debounce_cnt_21, 
                Q0=>I_debouncer_R_debounce_cnt_11);
    I_debouncer_SLICE_12I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_10, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_22, 
                DI0=>I_debouncer_un1_r_debounce_cnt_23, 
                A0=>I_debouncer_R_debounce_cnt_9, B0=>'X', C0=>'X', 
                D0=>I_debouncer_VCC, FCI=>I_debouncer_un1_r_debounce_cnt_cry_8, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, 
                LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_10, 
                F1=>I_debouncer_un1_r_debounce_cnt_22, 
                Q1=>I_debouncer_R_debounce_cnt_10, 
                F0=>I_debouncer_un1_r_debounce_cnt_23, 
                Q0=>I_debouncer_R_debounce_cnt_9);
    I_debouncer_SLICE_13I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_8, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_24, 
                DI0=>I_debouncer_un1_r_debounce_cnt_25, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_7, C0=>'X', D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_6, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_8, 
                F1=>I_debouncer_un1_r_debounce_cnt_24, 
                Q1=>I_debouncer_R_debounce_cnt_8, 
                F0=>I_debouncer_un1_r_debounce_cnt_25, 
                Q0=>I_debouncer_R_debounce_cnt_7);
    I_debouncer_SLICE_14I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG0_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_6, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_26, 
                DI0=>I_debouncer_un1_r_debounce_cnt_27, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_5, C0=>'X', D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_4, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_6, 
                F1=>I_debouncer_un1_r_debounce_cnt_26, 
                Q1=>I_debouncer_R_debounce_cnt_6, 
                F0=>I_debouncer_un1_r_debounce_cnt_27, 
                Q0=>I_debouncer_R_debounce_cnt_5);
    I_debouncer_SLICE_15I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_4, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_28, 
                DI0=>I_debouncer_un1_r_debounce_cnt_29, 
                A0=>I_debouncer_R_debounce_cnt_3, B0=>'X', C0=>'X', 
                D0=>I_debouncer_VCC, FCI=>I_debouncer_un1_r_debounce_cnt_cry_2, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, 
                LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_4, 
                F1=>I_debouncer_un1_r_debounce_cnt_28, 
                Q1=>I_debouncer_R_debounce_cnt_4, 
                F0=>I_debouncer_un1_r_debounce_cnt_29, 
                Q0=>I_debouncer_R_debounce_cnt_3);
    I_debouncer_SLICE_16I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_2, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>I_debouncer_un1_r_debounce_cnt_30, 
                DI0=>I_debouncer_un1_r_debounce_cnt_31, A0=>'X', 
                B0=>I_debouncer_R_debounce_cnt_1, C0=>'X', D0=>I_debouncer_VCC, 
                FCI=>I_debouncer_un1_r_debounce_cnt_cry_0, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>I_debouncer_r_debounce_cnt12_i, 
                FCO=>I_debouncer_un1_r_debounce_cnt_cry_2, 
                F1=>I_debouncer_un1_r_debounce_cnt_30, 
                Q1=>I_debouncer_R_debounce_cnt_2, 
                F0=>I_debouncer_un1_r_debounce_cnt_31, 
                Q0=>I_debouncer_R_debounce_cnt_1);
    I_debouncer_SLICE_17I: SCCU2B
      generic map (CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   INIT0_INITVAL=>"0x0000", INIT1_INITVAL=>"0x33CC")
      port map (M1=>'X', A1=>'X', B1=>I_debouncer_R_debounce_cnt_0, C1=>'X', 
                D1=>I_debouncer_VCC, DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', 
                C0=>'X', D0=>'X', FCI=>'X', M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', FCO=>I_debouncer_un1_r_debounce_cnt_cry_0, F1=>open, 
                Q1=>open, F0=>open, Q0=>open);
    SLICE_18I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0xCC00", INIT1_INITVAL=>"0x0000", 
                   REG0_SD=>"VHI", CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>'X', C1=>'X', D1=>'X', DI1=>'X', 
                DI0=>un7_r_s_7_0_S0, A0=>'X', B0=>led_c_7, C0=>'X', D0=>VCC, 
                FCI=>un7_r_cry_6, M0=>'X', CE=>'X', CLK=>clk_key, 
                LSR=>btn_right_c, FCO=>open, F1=>open, Q1=>open, 
                F0=>un7_r_s_7_0_S0, Q0=>led_c_7);
    SLICE_19I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0xCC00", INIT1_INITVAL=>"0xAA00", 
                   REG0_SD=>"VHI", CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>led_c_6, B1=>'X', C1=>'X', D1=>VCC, DI1=>'X', 
                DI0=>un7_r_cry_5_0_S0, A0=>'X', B0=>led_c_5, C0=>'X', D0=>VCC, 
                FCI=>un7_r_cry_4, M0=>'X', CE=>'X', CLK=>clk_key, 
                LSR=>btn_right_c, FCO=>un7_r_cry_6, F1=>un7_r_cry_5_0_S1, 
                Q1=>open, F0=>un7_r_cry_5_0_S0, Q0=>led_c_5);
    SLICE_20I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0xCC00", INIT1_INITVAL=>"0xCC00", 
                   REG1_SD=>"VHI", CHECK_DI1=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>led_c_4, C1=>'X', D1=>VCC, 
                DI1=>un7_r_cry_3_0_S1, DI0=>'X', A0=>'X', B0=>led_c_3, C0=>'X', 
                D0=>VCC, FCI=>un7_r_cry_2, M0=>'X', CE=>'X', CLK=>clk_key, 
                LSR=>btn_right_c, FCO=>un7_r_cry_4, F1=>un7_r_cry_3_0_S1, 
                Q1=>led_c_4, F0=>un7_r_cry_3_0_S0, Q0=>open);
    SLICE_21I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0xCC00", INIT1_INITVAL=>"0xCC00", 
                   REG1_SD=>"VHI", CHECK_DI1=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>led_c_2, C1=>'X', D1=>VCC, 
                DI1=>un7_r_cry_1_0_S1, DI0=>'X', A0=>'X', B0=>led_c_1, C0=>'X', 
                D0=>VCC, FCI=>un7_r_cry_0, M0=>'X', CE=>'X', CLK=>clk_key, 
                LSR=>btn_right_c, FCO=>un7_r_cry_2, F1=>un7_r_cry_1_0_S1, 
                Q1=>led_c_2, F0=>un7_r_cry_1_0_S0, Q0=>open);
    I_debouncer_SLICE_22I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", GSR=>"DISABLED", 
                   LUT0_INITVAL=>X"00FF", REG0_SD=>"VHI", CHECK_DI0=>TRUE, 
                   CHECK_LSR=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>I_debouncer_R_debounce_cnt_i_0, 
                A0=>'X', B0=>'X', C0=>'X', D0=>I_debouncer_R_debounce_cnt_0, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, 
                LSR=>I_debouncer_r_debounce_cnt12_i, OFX1=>open, F1=>open, 
                Q1=>open, OFX0=>open, F0=>I_debouncer_R_debounce_cnt_i_0, 
                Q0=>I_debouncer_R_debounce_cnt_0);
    SLICE_24I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", GSR=>"DISABLED", 
                   LUT0_INITVAL=>X"00FF", LUT1_INITVAL=>X"5F00", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>un2_r_4, B1=>'X', C1=>un2_r_5, 
                D1=>un7_r_cry_1_0_S0, DI1=>Rc_1, DI0=>led_c_i_0, A0=>'X', 
                B0=>'X', C0=>'X', D0=>led_c_0, M0=>'X', CE=>'X', CLK=>clk_key, 
                LSR=>btn_right_c, OFX1=>open, F1=>Rc_1, Q1=>led_c_1, 
                OFX0=>open, F0=>led_c_i_0, Q0=>led_c_0);
    SLICE_25I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", GSR=>"DISABLED", 
                   LUT0_INITVAL=>X"3F00", LUT1_INITVAL=>X"0CCC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>un7_r_cry_5_0_S1, 
                C1=>un2_r_4, D1=>un2_r_5, DI1=>Rc_0, DI0=>Rc, A0=>'X', 
                B0=>un2_r_5, C0=>un2_r_4, D0=>un7_r_cry_3_0_S0, M0=>'X', 
                CE=>'X', CLK=>clk_key, LSR=>btn_right_c, OFX1=>open, F1=>Rc_0, 
                Q1=>led_c_6, OFX0=>open, F0=>Rc, Q0=>led_c_3);
    SLICE_26I: SLOGICB
      generic map (LUT0_INITVAL=>X"0100")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>led_c_4, B0=>led_c_7, 
                C0=>led_c_5, D0=>led_c_0, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, F0=>un2_r_5, 
                Q0=>open);
    I_debouncer_SLICE_27I: SLOGICB
      generic map (LUT0_INITVAL=>X"4848")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>clk_key, 
                B0=>I_debouncer_R_debounce_cnt_31, C0=>I_debouncer_R_key_sync, 
                D0=>'X', M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, 
                F0=>I_debouncer_R_key_last_0_sqmuxa, Q0=>open);
    I_debouncer_SLICE_28I: SLOGICB
      generic map (M0MUX=>"SIG", CLKMUX=>"SIG", CEMUX=>"SIG", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"F00F", 
                   CHECK_M0=>TRUE, CHECK_CE=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', 
                C0=>I_debouncer_R_key_sync, D0=>clk_key, 
                M0=>I_debouncer_R_key_sync, 
                CE=>I_debouncer_R_key_last_0_sqmuxa, CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, 
                F0=>I_debouncer_r_debounce_cnt12_i, Q0=>clk_key);
    I_debouncer_SLICE_29I: SLOGICB
      generic map (LUT0_INITVAL=>X"FFFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', C0=>'X', 
                D0=>'X', M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>I_debouncer_VCC, Q0=>open);
    SLICE_30I: SLOGICB
      generic map (LUT0_INITVAL=>X"0008")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>led_c_6, B0=>led_c_3, 
                C0=>led_c_2, D0=>led_c_1, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, F0=>un2_r_4, 
                Q0=>open);
    SLICE_31I: SLOGICB
      generic map (LUT0_INITVAL=>X"FFFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', C0=>'X', 
                D0=>'X', M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>VCC, Q0=>open);
    led_0_I: led_0_B
      port map (PADDO=>led_c_0, led0=>led(0));
    clk_25mI: clk_25mB
      port map (PADDI=>clk_25m_c, clk25m=>clk_25m);
    led_7_I: led_7_B
      port map (PADDO=>led_c_7, led7=>led(7));
    led_6_I: led_6_B
      port map (PADDO=>led_c_6, led6=>led(6));
    led_5_I: led_5_B
      port map (PADDO=>led_c_5, led5=>led(5));
    led_4_I: led_4_B
      port map (PADDO=>led_c_4, led4=>led(4));
    led_3_I: led_3_B
      port map (PADDO=>led_c_3, led3=>led(3));
    led_2_I: led_2_B
      port map (PADDO=>led_c_2, led2=>led(2));
    led_1_I: led_1_B
      port map (PADDO=>led_c_1, led1=>led(1));
    btn_rightI: btn_rightB
      port map (PADDI=>btn_right_c, btnright=>btn_right);
    btn_upI: btn_upB
      port map (PADDI=>btn_up_c, btnup=>btn_up);
    btn_up_MGIOLI: btn_up_MGIOL
      port map (DI=>btn_up_c, CLK=>clk_25m_c, INFF=>I_debouncer_R_key_sync);
    VHI_INST: VHI
      port map (Z=>VCCI);
    PUR_INST: PUR
      port map (PUR=>VCCI);
    GSR_INST: GSR
      port map (GSR=>VCCI);
  end Structure;



  library IEEE, vital2000, XP2;
  configuration Structure_CON of count is
    for Structure
    end for;
  end Structure_CON;


