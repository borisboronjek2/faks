
-- VHDL netlist produced by program ldbanno, Version Diamond (64-bit) 3.11.0.396.4
-- ldbanno -n VHDL -o lab4_ce_impl1_vho.vho -w -neg -gui lab4_ce_impl1.ncd 
-- Netlist created on Thu Dec 10 21:19:08 2020
-- Netlist written on Thu Dec 10 21:19:25 2020
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
    component IBPD
      port (I: in Std_logic; O: out Std_logic);
    end component;
  begin
    INST1: IBPD
      port map (I=>PAD, O=>Z);
  end Structure;

-- entity btn_leftB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity btn_leftB is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "btn_leftB";

      tipd_btnleft  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_btnleft_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_btnleft 	: VitalDelayType := 0 ns;
      tpw_btnleft_posedge	: VitalDelayType := 0 ns;
      tpw_btnleft_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; btnleft: in Std_logic);

    ATTRIBUTE Vital_Level0 OF btn_leftB : ENTITY IS TRUE;

  end btn_leftB;

  architecture Structure of btn_leftB is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal btnleft_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    btn_left_pad: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>btnleft_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(btnleft_ipd, btnleft, tipd_btnleft);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, btnleft_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_btnleft_btnleft          	: x01 := '0';
    VARIABLE periodcheckinfo_btnleft	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => btnleft_ipd,
        TestSignalName => "btnleft",
        Period => tperiod_btnleft,
        PulseWidthHigh => tpw_btnleft_posedge,
        PulseWidthLow => tpw_btnleft_negedge,
        PeriodData => periodcheckinfo_btnleft,
        Violation => tviol_btnleft_btnleft,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => btnleft_ipd'last_event,
                           PathDelay => tpd_btnleft_PADDI,
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

-- entity sw_3_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity sw_3_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "sw_3_B";

      tipd_sw3  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_sw3_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_sw3 	: VitalDelayType := 0 ns;
      tpw_sw3_posedge	: VitalDelayType := 0 ns;
      tpw_sw3_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; sw3: in Std_logic);

    ATTRIBUTE Vital_Level0 OF sw_3_B : ENTITY IS TRUE;

  end sw_3_B;

  architecture Structure of sw_3_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal sw3_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    sw_pad_3: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>sw3_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(sw3_ipd, sw3, tipd_sw3);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, sw3_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_sw3_sw3          	: x01 := '0';
    VARIABLE periodcheckinfo_sw3	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => sw3_ipd,
        TestSignalName => "sw3",
        Period => tperiod_sw3,
        PulseWidthHigh => tpw_sw3_posedge,
        PulseWidthLow => tpw_sw3_negedge,
        PeriodData => periodcheckinfo_sw3,
        Violation => tviol_sw3_sw3,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => sw3_ipd'last_event,
                           PathDelay => tpd_sw3_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity sw_2_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity sw_2_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "sw_2_B";

      tipd_sw2  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_sw2_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_sw2 	: VitalDelayType := 0 ns;
      tpw_sw2_posedge	: VitalDelayType := 0 ns;
      tpw_sw2_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; sw2: in Std_logic);

    ATTRIBUTE Vital_Level0 OF sw_2_B : ENTITY IS TRUE;

  end sw_2_B;

  architecture Structure of sw_2_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal sw2_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    sw_pad_2: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>sw2_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(sw2_ipd, sw2, tipd_sw2);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, sw2_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_sw2_sw2          	: x01 := '0';
    VARIABLE periodcheckinfo_sw2	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => sw2_ipd,
        TestSignalName => "sw2",
        Period => tperiod_sw2,
        PulseWidthHigh => tpw_sw2_posedge,
        PulseWidthLow => tpw_sw2_negedge,
        PeriodData => periodcheckinfo_sw2,
        Violation => tviol_sw2_sw2,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => sw2_ipd'last_event,
                           PathDelay => tpd_sw2_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity sw_1_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity sw_1_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "sw_1_B";

      tipd_sw1  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_sw1_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_sw1 	: VitalDelayType := 0 ns;
      tpw_sw1_posedge	: VitalDelayType := 0 ns;
      tpw_sw1_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; sw1: in Std_logic);

    ATTRIBUTE Vital_Level0 OF sw_1_B : ENTITY IS TRUE;

  end sw_1_B;

  architecture Structure of sw_1_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal sw1_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    sw_pad_1: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>sw1_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(sw1_ipd, sw1, tipd_sw1);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, sw1_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_sw1_sw1          	: x01 := '0';
    VARIABLE periodcheckinfo_sw1	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => sw1_ipd,
        TestSignalName => "sw1",
        Period => tperiod_sw1,
        PulseWidthHigh => tpw_sw1_posedge,
        PulseWidthLow => tpw_sw1_negedge,
        PeriodData => periodcheckinfo_sw1,
        Violation => tviol_sw1_sw1,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => sw1_ipd'last_event,
                           PathDelay => tpd_sw1_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity sw_0_B
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity sw_0_B is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "sw_0_B";

      tipd_sw0  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_sw0_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_sw0 	: VitalDelayType := 0 ns;
      tpw_sw0_posedge	: VitalDelayType := 0 ns;
      tpw_sw0_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; sw0: in Std_logic);

    ATTRIBUTE Vital_Level0 OF sw_0_B : ENTITY IS TRUE;

  end sw_0_B;

  architecture Structure of sw_0_B is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal sw0_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    sw_pad_0: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>sw0_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(sw0_ipd, sw0, tipd_sw0);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, sw0_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_sw0_sw0          	: x01 := '0';
    VARIABLE periodcheckinfo_sw0	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => sw0_ipd,
        TestSignalName => "sw0",
        Period => tperiod_sw0,
        PulseWidthHigh => tpw_sw0_posedge,
        PulseWidthLow => tpw_sw0_negedge,
        PeriodData => periodcheckinfo_sw0,
        Violation => tviol_sw0_sw0,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => sw0_ipd'last_event,
                           PathDelay => tpd_sw0_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity btn_downB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity btn_downB is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "btn_downB";

      tipd_btndown  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_btndown_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_btndown 	: VitalDelayType := 0 ns;
      tpw_btndown_posedge	: VitalDelayType := 0 ns;
      tpw_btndown_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; btndown: in Std_logic);

    ATTRIBUTE Vital_Level0 OF btn_downB : ENTITY IS TRUE;

  end btn_downB;

  architecture Structure of btn_downB is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal btndown_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    btn_down_pad: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>btndown_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(btndown_ipd, btndown, tipd_btndown);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, btndown_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_btndown_btndown          	: x01 := '0';
    VARIABLE periodcheckinfo_btndown	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => btndown_ipd,
        TestSignalName => "btndown",
        Period => tperiod_btndown,
        PulseWidthHigh => tpw_btndown_posedge,
        PulseWidthLow => tpw_btndown_negedge,
        PeriodData => periodcheckinfo_btndown,
        Violation => tviol_btndown_btndown,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => btndown_ipd'last_event,
                           PathDelay => tpd_btndown_PADDI,
                           PathCondition => TRUE)),
      GlitchData => PADDI_GlitchData,
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

    component ec2iobuf0002
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    clk_25m_pad: ec2iobuf0002
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

-- entity count
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity count is
    port (btn_left: in Std_logic; clk_25m: in Std_logic; 
          btn_down: in Std_logic; sw: in Std_logic_vector (3 downto 0); 
          led: out Std_logic_vector (7 downto 0));



  end count;

  architecture Structure of count is
    signal R_0: Std_logic;
    signal sw_c_0: Std_logic;
    signal btn_left_c: Std_logic;
    signal R_2_cry_0: Std_logic;
    signal VCC: Std_logic;
    signal R_31: Std_logic;
    signal R_2_31: Std_logic;
    signal clk_25m_c: Std_logic;
    signal R_2_cry_30: Std_logic;
    signal R_30: Std_logic;
    signal R_29: Std_logic;
    signal R_2_30: Std_logic;
    signal R_2_29: Std_logic;
    signal R_2_cry_28: Std_logic;
    signal R_28: Std_logic;
    signal R_27: Std_logic;
    signal R_2_28: Std_logic;
    signal R_2_27: Std_logic;
    signal R_2_cry_26: Std_logic;
    signal R_26: Std_logic;
    signal R_25: Std_logic;
    signal R_2_26: Std_logic;
    signal R_2_25: Std_logic;
    signal R_2_cry_24: Std_logic;
    signal R_24: Std_logic;
    signal R_23: Std_logic;
    signal R_2_24: Std_logic;
    signal R_2_23: Std_logic;
    signal R_2_cry_22: Std_logic;
    signal R_22: Std_logic;
    signal R_21: Std_logic;
    signal R_2_22: Std_logic;
    signal R_2_21: Std_logic;
    signal R_2_cry_20: Std_logic;
    signal R_20: Std_logic;
    signal R_19: Std_logic;
    signal R_2_20: Std_logic;
    signal R_2_19: Std_logic;
    signal R_2_cry_18: Std_logic;
    signal R_18: Std_logic;
    signal R_17: Std_logic;
    signal R_2_18: Std_logic;
    signal R_2_17: Std_logic;
    signal R_2_cry_16: Std_logic;
    signal R_16: Std_logic;
    signal R_15: Std_logic;
    signal R_2_16: Std_logic;
    signal R_2_15: Std_logic;
    signal R_2_cry_14: Std_logic;
    signal R_14: Std_logic;
    signal R_13: Std_logic;
    signal R_2_14: Std_logic;
    signal R_2_13: Std_logic;
    signal R_2_cry_12: Std_logic;
    signal R_12: Std_logic;
    signal R_11: Std_logic;
    signal R_2_12: Std_logic;
    signal R_2_11: Std_logic;
    signal R_2_cry_10: Std_logic;
    signal R_10: Std_logic;
    signal R_9: Std_logic;
    signal R_2_10: Std_logic;
    signal R_2_9: Std_logic;
    signal R_2_cry_8: Std_logic;
    signal R_8: Std_logic;
    signal R_7: Std_logic;
    signal R_2_8: Std_logic;
    signal R_2_7: Std_logic;
    signal R_2_cry_6: Std_logic;
    signal R_6: Std_logic;
    signal R_5: Std_logic;
    signal R_2_6: Std_logic;
    signal R_2_5: Std_logic;
    signal R_2_cry_4: Std_logic;
    signal R_4: Std_logic;
    signal R_3: Std_logic;
    signal sw_c_3: Std_logic;
    signal R_2_4: Std_logic;
    signal R_2_3: Std_logic;
    signal R_2_cry_2: Std_logic;
    signal R_2: Std_logic;
    signal sw_c_2: Std_logic;
    signal R_1: Std_logic;
    signal sw_c_1: Std_logic;
    signal R_2_2: Std_logic;
    signal R_2_1: Std_logic;
    signal R_2_0: Std_logic;
    signal btn_down_c: Std_logic;
    signal led_c_7: Std_logic;
    signal led_c_0: Std_logic;
    signal led_c_1: Std_logic;
    signal led_c_2: Std_logic;
    signal led_c_3: Std_logic;
    signal led_c_4: Std_logic;
    signal led_c_5: Std_logic;
    signal led_c_6: Std_logic;
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
    component btn_leftB
      port (PADDI: out Std_logic; btnleft: in Std_logic);
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
    component sw_3_B
      port (PADDI: out Std_logic; sw3: in Std_logic);
    end component;
    component sw_2_B
      port (PADDI: out Std_logic; sw2: in Std_logic);
    end component;
    component sw_1_B
      port (PADDI: out Std_logic; sw1: in Std_logic);
    end component;
    component sw_0_B
      port (PADDI: out Std_logic; sw0: in Std_logic);
    end component;
    component btn_downB
      port (PADDI: out Std_logic; btndown: in Std_logic);
    end component;
    component clk_25mB
      port (PADDI: out Std_logic; clk25m: in Std_logic);
    end component;
  begin
    SLICE_0I: SCCU2B
      generic map (CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   INIT0_INITVAL=>"0x0000", INIT1_INITVAL=>"0x7878")
      port map (M1=>'X', A1=>btn_left_c, B1=>sw_c_0, C1=>R_0, D1=>'X', 
                DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', C0=>'X', D0=>'X', 
                FCI=>'X', M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', FCO=>R_2_cry_0, 
                F1=>open, Q1=>open, F0=>open, Q0=>open);
    SLICE_1I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0x0000", REG0_SD=>"VHI", CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>'X', C1=>'X', D1=>'X', DI1=>'X', 
                DI0=>R_2_31, A0=>'X', B0=>R_31, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_30, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>open, F1=>open, Q1=>open, F0=>R_2_31, Q0=>R_31);
    SLICE_2I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_30, C1=>'X', D1=>VCC, DI1=>R_2_30, 
                DI0=>R_2_29, A0=>'X', B0=>R_29, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_28, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_30, F1=>R_2_30, Q1=>R_30, F0=>R_2_29, Q0=>R_29);
    SLICE_3I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xAA00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_28, C1=>'X', D1=>VCC, DI1=>R_2_28, 
                DI0=>R_2_27, A0=>R_27, B0=>'X', C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_26, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_28, F1=>R_2_28, Q1=>R_28, F0=>R_2_27, Q0=>R_27);
    SLICE_4I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_26, C1=>'X', D1=>VCC, DI1=>R_2_26, 
                DI0=>R_2_25, A0=>'X', B0=>R_25, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_24, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_26, F1=>R_2_26, Q1=>R_26, F0=>R_2_25, Q0=>R_25);
    SLICE_5I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_24, C1=>'X', D1=>VCC, DI1=>R_2_24, 
                DI0=>R_2_23, A0=>'X', B0=>R_23, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_22, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_24, F1=>R_2_24, Q1=>R_24, F0=>R_2_23, Q0=>R_23);
    SLICE_6I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xAA00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_22, C1=>'X', D1=>VCC, DI1=>R_2_22, 
                DI0=>R_2_21, A0=>R_21, B0=>'X', C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_20, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_22, F1=>R_2_22, Q1=>R_22, F0=>R_2_21, Q0=>R_21);
    SLICE_7I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_20, C1=>'X', D1=>VCC, DI1=>R_2_20, 
                DI0=>R_2_19, A0=>'X', B0=>R_19, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_18, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_20, F1=>R_2_20, Q1=>R_20, F0=>R_2_19, Q0=>R_19);
    SLICE_8I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_18, C1=>'X', D1=>VCC, DI1=>R_2_18, 
                DI0=>R_2_17, A0=>'X', B0=>R_17, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_16, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_18, F1=>R_2_18, Q1=>R_18, F0=>R_2_17, Q0=>R_17);
    SLICE_9I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xAA00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_16, C1=>'X', D1=>VCC, DI1=>R_2_16, 
                DI0=>R_2_15, A0=>R_15, B0=>'X', C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_14, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_16, F1=>R_2_16, Q1=>R_16, F0=>R_2_15, Q0=>R_15);
    SLICE_10I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_14, C1=>'X', D1=>VCC, DI1=>R_2_14, 
                DI0=>R_2_13, A0=>'X', B0=>R_13, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_12, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_14, F1=>R_2_14, Q1=>R_14, F0=>R_2_13, Q0=>R_13);
    SLICE_11I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_12, C1=>'X', D1=>VCC, DI1=>R_2_12, 
                DI0=>R_2_11, A0=>'X', B0=>R_11, C0=>'X', D0=>VCC, 
                FCI=>R_2_cry_10, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_12, F1=>R_2_12, Q1=>R_12, F0=>R_2_11, Q0=>R_11);
    SLICE_12I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xAA00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_10, C1=>'X', D1=>VCC, DI1=>R_2_10, 
                DI0=>R_2_9, A0=>R_9, B0=>'X', C0=>'X', D0=>VCC, FCI=>R_2_cry_8, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', FCO=>R_2_cry_10, 
                F1=>R_2_10, Q1=>R_10, F0=>R_2_9, Q0=>R_9);
    SLICE_13I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_8, C1=>'X', D1=>VCC, DI1=>R_2_8, 
                DI0=>R_2_7, A0=>'X', B0=>R_7, C0=>'X', D0=>VCC, FCI=>R_2_cry_6, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', FCO=>R_2_cry_8, 
                F1=>R_2_8, Q1=>R_8, F0=>R_2_7, Q0=>R_7);
    SLICE_14I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_6, C1=>'X', D1=>VCC, DI1=>R_2_6, 
                DI0=>R_2_5, A0=>'X', B0=>R_5, C0=>'X', D0=>VCC, FCI=>R_2_cry_4, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', FCO=>R_2_cry_6, 
                F1=>R_2_6, Q1=>R_6, F0=>R_2_5, Q0=>R_5);
    SLICE_15I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0x7878", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>R_4, C1=>'X', D1=>VCC, DI1=>R_2_4, 
                DI0=>R_2_3, A0=>btn_left_c, B0=>sw_c_3, C0=>R_3, D0=>'X', 
                FCI=>R_2_cry_2, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                FCO=>R_2_cry_4, F1=>R_2_4, Q1=>R_4, F0=>R_2_3, Q0=>R_3);
    SLICE_16I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0x7878", 
                   INIT1_INITVAL=>"0x7878", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>sw_c_2, B1=>btn_left_c, C1=>R_2, D1=>'X', 
                DI1=>R_2_2, DI0=>R_2_1, A0=>sw_c_1, B0=>btn_left_c, C0=>R_1, 
                D0=>'X', FCI=>R_2_cry_0, M0=>'X', CE=>'X', CLK=>clk_25m_c, 
                LSR=>'X', FCO=>R_2_cry_2, F1=>R_2_2, Q1=>R_2, F0=>R_2_1, 
                Q0=>R_1);
    SLICE_17I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"7788", 
                   REG0_SD=>"VHI", CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>R_2_0, A0=>btn_left_c, B0=>sw_c_0, 
                C0=>'X', D0=>R_0, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, F0=>R_2_0, Q0=>R_0);
    SLICE_18I: SLOGICB
      generic map (LUT0_INITVAL=>X"FA0A")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>R_31, B0=>'X', C0=>btn_down_c, 
                D0=>R_23, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>led_c_7, Q0=>open);
    SLICE_19I: SLOGICB
      generic map (LUT0_INITVAL=>X"CCAA")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>R_24, B0=>R_16, C0=>'X', 
                D0=>btn_down_c, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, F0=>led_c_0, 
                Q0=>open);
    SLICE_20I: SLOGICB
      generic map (LUT0_INITVAL=>X"F3C0")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>btn_down_c, C0=>R_17, 
                D0=>R_25, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>led_c_1, Q0=>open);
    SLICE_21I: SLOGICB
      generic map (LUT0_INITVAL=>X"DD88")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>btn_down_c, B0=>R_18, C0=>'X', 
                D0=>R_26, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>led_c_2, Q0=>open);
    SLICE_22I: SLOGICB
      generic map (LUT0_INITVAL=>X"F0CC")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>R_27, C0=>R_19, 
                D0=>btn_down_c, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, F0=>led_c_3, 
                Q0=>open);
    SLICE_23I: SLOGICB
      generic map (LUT0_INITVAL=>X"CCAA")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>R_28, B0=>R_20, C0=>'X', 
                D0=>btn_down_c, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, F0=>led_c_4, 
                Q0=>open);
    SLICE_24I: SLOGICB
      generic map (LUT0_INITVAL=>X"FC30")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>btn_down_c, C0=>R_29, 
                D0=>R_21, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>led_c_5, Q0=>open);
    SLICE_25I: SLOGICB
      generic map (LUT0_INITVAL=>X"CCAA")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>R_30, B0=>R_22, C0=>'X', 
                D0=>btn_down_c, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, F0=>led_c_6, 
                Q0=>open);
    SLICE_26I: SLOGICB
      generic map (LUT0_INITVAL=>X"FFFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', C0=>'X', 
                D0=>'X', M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>VCC, Q0=>open);
    led_0_I: led_0_B
      port map (PADDO=>led_c_0, led0=>led(0));
    btn_leftI: btn_leftB
      port map (PADDI=>btn_left_c, btnleft=>btn_left);
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
    sw_3_I: sw_3_B
      port map (PADDI=>sw_c_3, sw3=>sw(3));
    sw_2_I: sw_2_B
      port map (PADDI=>sw_c_2, sw2=>sw(2));
    sw_1_I: sw_1_B
      port map (PADDI=>sw_c_1, sw1=>sw(1));
    sw_0_I: sw_0_B
      port map (PADDI=>sw_c_0, sw0=>sw(0));
    btn_downI: btn_downB
      port map (PADDI=>btn_down_c, btndown=>btn_down);
    clk_25mI: clk_25mB
      port map (PADDI=>clk_25m_c, clk25m=>clk_25m);
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


