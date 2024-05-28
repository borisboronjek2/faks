
-- VHDL netlist produced by program ldbanno, Version Diamond (64-bit) 3.11.0.396.4
-- ldbanno -n VHDL -o slova_impl1_vho.vho -w -neg -gui slova_impl1.ncd 
-- Netlist created on Wed Dec 02 23:22:19 2020
-- Netlist written on Wed Dec 02 23:22:37 2020
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

-- entity rs232_txB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity rs232_txB is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "rs232_txB";

      tipd_IOLDO  	: VitalDelayType01 := (0 ns, 0 ns);

        tpd_IOLDO_rs232tx	 : VitalDelayType01Z := (0 ns, 0 ns, 0 ns , 0 ns, 0 ns, 0 ns)
        );

    port (IOLDO: in Std_logic; rs232tx: out Std_logic);

    ATTRIBUTE Vital_Level0 OF rs232_txB : ENTITY IS TRUE;

  end rs232_txB;

  architecture Structure of rs232_txB is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal IOLDO_ipd 	: std_logic := 'X';
    signal rs232tx_out 	: std_logic := 'X';

    component ec2iobuf
      port (I: in Std_logic; PAD: out Std_logic);
    end component;
  begin
    rs232_tx_pad: ec2iobuf
      port map (I=>IOLDO_ipd, PAD=>rs232tx_out);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(IOLDO_ipd, IOLDO, tipd_IOLDO);
    END BLOCK;

    VitalBehavior : PROCESS (IOLDO_ipd, rs232tx_out)
    VARIABLE rs232tx_zd         	: std_logic := 'X';
    VARIABLE rs232tx_GlitchData 	: VitalGlitchDataType;


    BEGIN

    IF (TimingChecksOn) THEN

    END IF;

    rs232tx_zd 	:= rs232tx_out;

    VitalPathDelay01Z (
      OutSignal => rs232tx, OutSignalName => "rs232tx", OutTemp => rs232tx_zd,
      Paths      => (0 => (InputChangeTime => IOLDO_ipd'last_event,
                           PathDelay => tpd_IOLDO_rs232tx,
                           PathCondition => TRUE)),
      GlitchData => rs232tx_GlitchData,
      Mode       => vitaltransport, XOn => XOn, MsgOn => MsgOn);

    END PROCESS;

  end Structure;

-- entity mfflsre
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity mfflsre is
    port (D0: in Std_logic; SP: in Std_logic; CK: in Std_logic; 
          LSR: in Std_logic; Q: out Std_logic);

    ATTRIBUTE Vital_Level0 OF mfflsre : ENTITY IS TRUE;

  end mfflsre;

  architecture Structure of mfflsre is
    component FD1P3BX
      generic (GSR: String);
      port (D: in Std_logic; SP: in Std_logic; CK: in Std_logic; 
            PD: in Std_logic; Q: out Std_logic);
    end component;
  begin
    INST01: FD1P3BX
      generic map (GSR => "DISABLED")
      port map (D=>D0, SP=>SP, CK=>CK, PD=>LSR, Q=>Q);
  end Structure;

-- entity gndB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity gndB is
    port (PWR0: out Std_logic);

    ATTRIBUTE Vital_Level0 OF gndB : ENTITY IS TRUE;

  end gndB;

  architecture Structure of gndB is
    component VLO
      port (Z: out Std_logic);
    end component;
  begin
    INST1: VLO
      port map (Z=>PWR0);
  end Structure;

-- entity rs232_tx_MGIOL
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity rs232_tx_MGIOL is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "rs232_tx_MGIOL";

      tipd_ONEG0  	: VitalDelayType01 := (0 ns, 0 ns);
      tipd_CE  	: VitalDelayType01 := (0 ns, 0 ns);
      tipd_CLK  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_CLK_IOLDO	 : VitalDelayType01 := (0 ns, 0 ns);
      ticd_CLK	: VitalDelayType := 0 ns;
      tisd_ONEG0_CLK	: VitalDelayType := 0 ns;
      tsetup_ONEG0_CLK_noedge_posedge	: VitalDelayType := 0 ns;
      thold_ONEG0_CLK_noedge_posedge	: VitalDelayType := 0 ns;
      tisd_CE_CLK	: VitalDelayType := 0 ns;
      tsetup_CE_CLK_noedge_posedge	: VitalDelayType := 0 ns;
      thold_CE_CLK_noedge_posedge	: VitalDelayType := 0 ns);

    port (IOLDO: out Std_logic; ONEG0: in Std_logic; CE: in Std_logic; 
          CLK: in Std_logic);

    ATTRIBUTE Vital_Level0 OF rs232_tx_MGIOL : ENTITY IS TRUE;

  end rs232_tx_MGIOL;

  architecture Structure of rs232_tx_MGIOL is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal IOLDO_out 	: std_logic := 'X';
    signal ONEG0_ipd 	: std_logic := 'X';
    signal ONEG0_dly 	: std_logic := 'X';
    signal CE_ipd 	: std_logic := 'X';
    signal CE_dly 	: std_logic := 'X';
    signal CLK_ipd 	: std_logic := 'X';
    signal CLK_dly 	: std_logic := 'X';

    signal GNDI: Std_logic;
    component gndB
      port (PWR0: out Std_logic);
    end component;
    component mfflsre
      port (D0: in Std_logic; SP: in Std_logic; CK: in Std_logic; 
            LSR: in Std_logic; Q: out Std_logic);
    end component;
  begin
    serializer_R_tx_serio_0: mfflsre
      port map (D0=>ONEG0_dly, SP=>CE_dly, CK=>CLK_dly, LSR=>GNDI, 
                Q=>IOLDO_out);
    DRIVEGND: gndB
      port map (PWR0=>GNDI);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(ONEG0_ipd, ONEG0, tipd_ONEG0);
      VitalWireDelay(CE_ipd, CE, tipd_CE);
      VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
    END BLOCK;

    --  Setup and Hold DELAYs
    SignalDelay : BLOCK
    BEGIN
      VitalSignalDelay(ONEG0_dly, ONEG0_ipd, tisd_ONEG0_CLK);
      VitalSignalDelay(CE_dly, CE_ipd, tisd_CE_CLK);
      VitalSignalDelay(CLK_dly, CLK_ipd, ticd_CLK);
    END BLOCK;

    VitalBehavior : PROCESS (IOLDO_out, ONEG0_dly, CE_dly, CLK_dly)
    VARIABLE IOLDO_zd         	: std_logic := 'X';
    VARIABLE IOLDO_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_ONEG0_CLK       	: x01 := '0';
    VARIABLE ONEG0_CLK_TimingDatash	: VitalTimingDataType;
    VARIABLE tviol_CE_CLK       	: x01 := '0';
    VARIABLE CE_CLK_TimingDatash	: VitalTimingDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalSetupHoldCheck (
        TestSignal => ONEG0_dly,
        TestSignalName => "ONEG0",
        TestDelay => tisd_ONEG0_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_ONEG0_CLK_noedge_posedge,
        SetupLow => tsetup_ONEG0_CLK_noedge_posedge,
        HoldHigh => thold_ONEG0_CLK_noedge_posedge,
        HoldLow => thold_ONEG0_CLK_noedge_posedge,
        CheckEnabled => TRUE,
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => ONEG0_CLK_TimingDatash,
        Violation => tviol_ONEG0_CLK,
        MsgSeverity => warning);
      VitalSetupHoldCheck (
        TestSignal => CE_dly,
        TestSignalName => "CE",
        TestDelay => tisd_CE_CLK,
        RefSignal => CLK_dly,
        RefSignalName => "CLK",
        RefDelay => ticd_CLK,
        SetupHigh => tsetup_CE_CLK_noedge_posedge,
        SetupLow => tsetup_CE_CLK_noedge_posedge,
        HoldHigh => thold_CE_CLK_noedge_posedge,
        HoldLow => thold_CE_CLK_noedge_posedge,
        CheckEnabled => TRUE,
        RefTransition => '/',
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        TimingData => CE_CLK_TimingDatash,
        Violation => tviol_CE_CLK,
        MsgSeverity => warning);

    END IF;

    IOLDO_zd 	:= IOLDO_out;

    VitalPathDelay01 (
      OutSignal => IOLDO, OutSignalName => "IOLDO", OutTemp => IOLDO_zd,
      Paths      => (0 => (InputChangeTime => CLK_dly'last_event,
                           PathDelay => tpd_CLK_IOLDO,
                           PathCondition => TRUE)),
      GlitchData => IOLDO_GlitchData,
      Mode       => ondetect, XOn => XOn, MsgOn => MsgOn);

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

-- entity btn_centerB
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity btn_centerB is
    -- miscellaneous vital GENERICs
    GENERIC (
      TimingChecksOn	: boolean := TRUE;
      XOn           	: boolean := FALSE;
      MsgOn         	: boolean := TRUE;
      InstancePath  	: string := "btn_centerB";

      tipd_btncenter  	: VitalDelayType01 := (0 ns, 0 ns);
      tpd_btncenter_PADDI	 : VitalDelayType01 := (0 ns, 0 ns);
      tperiod_btncenter 	: VitalDelayType := 0 ns;
      tpw_btncenter_posedge	: VitalDelayType := 0 ns;
      tpw_btncenter_negedge	: VitalDelayType := 0 ns);

    port (PADDI: out Std_logic; btncenter: in Std_logic);

    ATTRIBUTE Vital_Level0 OF btn_centerB : ENTITY IS TRUE;

  end btn_centerB;

  architecture Structure of btn_centerB is
    ATTRIBUTE Vital_Level0 OF Structure : ARCHITECTURE IS TRUE;

    signal PADDI_out 	: std_logic := 'X';
    signal btncenter_ipd 	: std_logic := 'X';

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    btn_center_pad: ec2iobuf0001
      port map (Z=>PADDI_out, PAD=>btncenter_ipd);

    --  INPUT PATH DELAYs
    WireDelay : BLOCK
    BEGIN
      VitalWireDelay(btncenter_ipd, btncenter, tipd_btncenter);
    END BLOCK;

    VitalBehavior : PROCESS (PADDI_out, btncenter_ipd)
    VARIABLE PADDI_zd         	: std_logic := 'X';
    VARIABLE PADDI_GlitchData 	: VitalGlitchDataType;

    VARIABLE tviol_btncenter_btncenter          	: x01 := '0';
    VARIABLE periodcheckinfo_btncenter	: VitalPeriodDataType;

    BEGIN

    IF (TimingChecksOn) THEN
      VitalPeriodPulseCheck (
        TestSignal => btncenter_ipd,
        TestSignalName => "btncenter",
        Period => tperiod_btncenter,
        PulseWidthHigh => tpw_btncenter_posedge,
        PulseWidthLow => tpw_btncenter_negedge,
        PeriodData => periodcheckinfo_btncenter,
        Violation => tviol_btncenter_btncenter,
        MsgOn => MsgOn, XOn => XOn,
        HeaderMsg => InstancePath,
        CheckEnabled => TRUE,
        MsgSeverity => warning);

    END IF;

    PADDI_zd 	:= PADDI_out;

    VitalPathDelay01 (
      OutSignal => PADDI, OutSignalName => "PADDI", OutTemp => PADDI_zd,
      Paths      => (0 => (InputChangeTime => btncenter_ipd'last_event,
                           PathDelay => tpd_btncenter_PADDI,
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

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    btn_up_pad: ec2iobuf0001
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

    component ec2iobuf0001
      port (Z: out Std_logic; PAD: in Std_logic);
    end component;
  begin
    btn_right_pad: ec2iobuf0001
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

-- entity slova
  library IEEE, vital2000, XP2;
  use IEEE.STD_LOGIC_1164.all;
  use vital2000.vital_timing.all;
  use XP2.COMPONENTS.ALL;

  entity slova is
    port (btn_left: in Std_logic; btn_right: in Std_logic; 
          btn_up: in Std_logic; btn_down: in Std_logic; 
          btn_center: in Std_logic; rs232_tx: out Std_logic; 
          clk_25m: in Std_logic; led: out Std_logic_vector (7 downto 0); 
          sw: in Std_logic_vector (3 downto 0));



  end slova;

  architecture Structure of slova is
    signal serializer_VCC: Std_logic;
    signal serializer_R_debounce_cnt_0: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_0_s1: Std_logic;
    signal btn_center_c: Std_logic;
    signal serializer_a_1_i_a2_0_0_7: Std_logic;
    signal serializer_R_byte_old_6: Std_logic;
    signal sw_c_0: Std_logic;
    signal serializer_un1_byte_in_0_data_tmp_2: Std_logic;
    signal serializer_un1_byte_in_i: Std_logic;
    signal led_c_4: Std_logic;
    signal serializer_R_byte_old_5: Std_logic;
    signal serializer_R_byte_old_4: Std_logic;
    signal led_c_5: Std_logic;
    signal serializer_R_byte_old_3: Std_logic;
    signal led_c_2: Std_logic;
    signal serializer_R_byte_old_2: Std_logic;
    signal led_c_3: Std_logic;
    signal serializer_un1_byte_in_0_data_tmp_0: Std_logic;
    signal serializer_R_byte_old_0: Std_logic;
    signal led_c_0: Std_logic;
    signal led_c_1: Std_logic;
    signal serializer_R_byte_old_1: Std_logic;
    signal serializer_R_baudgen_15: Std_logic;
    signal serializer_un4_r_baudgen_16: Std_logic;
    signal serializer_un4_r_baudgen_15: Std_logic;
    signal clk_25m_c: Std_logic;
    signal serializer_un4_r_baudgen_cry_14: Std_logic;
    signal serializer_R_baudgen_16: Std_logic;
    signal serializer_R_baudgen_14: Std_logic;
    signal serializer_R_baudgen_13: Std_logic;
    signal serializer_un4_r_baudgen_14: Std_logic;
    signal serializer_un4_r_baudgen_13: Std_logic;
    signal serializer_un4_r_baudgen_cry_12: Std_logic;
    signal serializer_R_baudgen_12: Std_logic;
    signal serializer_R_baudgen_11: Std_logic;
    signal serializer_un4_r_baudgen_12: Std_logic;
    signal serializer_un4_r_baudgen_11: Std_logic;
    signal serializer_un4_r_baudgen_cry_10: Std_logic;
    signal serializer_R_baudgen_10: Std_logic;
    signal serializer_R_baudgen_9: Std_logic;
    signal serializer_un4_r_baudgen_10: Std_logic;
    signal serializer_un4_r_baudgen_9: Std_logic;
    signal serializer_un4_r_baudgen_cry_8: Std_logic;
    signal serializer_R_baudgen_8: Std_logic;
    signal serializer_R_baudgen_7: Std_logic;
    signal serializer_un4_r_baudgen_8: Std_logic;
    signal serializer_un4_r_baudgen_7: Std_logic;
    signal serializer_un4_r_baudgen_cry_6: Std_logic;
    signal serializer_R_baudgen_6: Std_logic;
    signal serializer_R_baudgen_5: Std_logic;
    signal serializer_un4_r_baudgen_6: Std_logic;
    signal serializer_un4_r_baudgen_5: Std_logic;
    signal serializer_un4_r_baudgen_cry_4: Std_logic;
    signal serializer_R_baudgen_4: Std_logic;
    signal serializer_R_baudgen_3: Std_logic;
    signal serializer_un4_r_baudgen_4: Std_logic;
    signal serializer_un4_r_baudgen_3: Std_logic;
    signal serializer_un4_r_baudgen_cry_2: Std_logic;
    signal serializer_R_baudgen_2: Std_logic;
    signal serializer_R_baudgen_1: Std_logic;
    signal serializer_un4_r_baudgen_2: Std_logic;
    signal serializer_un4_r_baudgen_1: Std_logic;
    signal serializer_un4_r_baudgen_cry_0: Std_logic;
    signal serializer_R_baudgen_0: Std_logic;
    signal serializer_R_debounce_cnt_31: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_0: Std_logic;
    signal serializer_un1_R_debounce_cnt_1_i: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_30_s1: Std_logic;
    signal serializer_R_debounce_cnt_30: Std_logic;
    signal serializer_R_debounce_cnt_29: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_1: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_2: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_28_s1: Std_logic;
    signal serializer_R_debounce_cnt_28: Std_logic;
    signal serializer_R_debounce_cnt_27: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_3: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_4: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_26_s1: Std_logic;
    signal serializer_R_debounce_cnt_26: Std_logic;
    signal serializer_R_debounce_cnt_25: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_5: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_6: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_24_s1: Std_logic;
    signal serializer_R_debounce_cnt_24: Std_logic;
    signal serializer_R_debounce_cnt_23: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_7: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_8: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_22_s1: Std_logic;
    signal serializer_R_debounce_cnt_22: Std_logic;
    signal serializer_R_debounce_cnt_21: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_9: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_10: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_20_s1: Std_logic;
    signal serializer_R_debounce_cnt_20: Std_logic;
    signal serializer_R_debounce_cnt_19: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_11: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_12: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_18_s1: Std_logic;
    signal serializer_R_debounce_cnt_18: Std_logic;
    signal serializer_R_debounce_cnt_17: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_13: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_14: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_16_s1: Std_logic;
    signal serializer_R_debounce_cnt_16: Std_logic;
    signal serializer_R_debounce_cnt_15: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_15: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_16: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_14_s1: Std_logic;
    signal serializer_R_debounce_cnt_14: Std_logic;
    signal serializer_R_debounce_cnt_13: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_17: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_18: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_12_s1: Std_logic;
    signal serializer_R_debounce_cnt_12: Std_logic;
    signal serializer_R_debounce_cnt_11: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_19: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_20: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_10_s1: Std_logic;
    signal serializer_R_debounce_cnt_10: Std_logic;
    signal serializer_R_debounce_cnt_9: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_21: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_22: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_8_s1: Std_logic;
    signal serializer_R_debounce_cnt_8: Std_logic;
    signal serializer_R_debounce_cnt_7: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_23: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_24: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_6_s1: Std_logic;
    signal serializer_R_debounce_cnt_6: Std_logic;
    signal serializer_R_debounce_cnt_5: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_25: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_26: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_4_s1: Std_logic;
    signal serializer_R_debounce_cnt_4: Std_logic;
    signal serializer_R_debounce_cnt_3: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_27: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_28: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_cry_2_s1: Std_logic;
    signal serializer_R_debounce_cnt_2: Std_logic;
    signal serializer_R_debounce_cnt_1: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_29: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_s1_30: Std_logic;
    signal serializer_R_baudgen_i_0: Std_logic;
    signal serializer_a_6: Std_logic;
    signal btn_up_c: Std_logic;
    signal modul_brojke_N_17: Std_logic;
    signal btn_right_c: Std_logic;
    signal modul_brojke_N_19: Std_logic;
    signal btn_down_c: Std_logic;
    signal btn_left_c: Std_logic;
    signal serializer_N_24: Std_logic;
    signal serializer_N_7: Std_logic;
    signal led_c_6: Std_logic;
    signal serializer_g0_3_6: Std_logic;
    signal serializer_g0_3_5: Std_logic;
    signal serializer_g0_3_4: Std_logic;
    signal serializer_un1_R_debounce_cnt_1_3: Std_logic;
    signal serializer_un14_r_debounce_cnt_30: Std_logic;
    signal serializer_un1_R_debounce_cnt_3_31: Std_logic;
    signal serializer_R_tx_ser_0_sqmuxa: Std_logic;
    signal serializer_R_tx_phase_0: Std_logic;
    signal serializer_R_tx_phase_1: Std_logic;
    signal serializer_un14_r_debounce_cnt_0_0: Std_logic;
    signal serializer_g0_0_14: Std_logic;
    signal serializer_g0_0_15: Std_logic;
    signal serializer_R_tx_phase_7_1: Std_logic;
    signal serializer_R_tx_phase_7_0: Std_logic;
    signal serializer_R_tx_phase_0_sqmuxa: Std_logic;
    signal serializer_g0_11: Std_logic;
    signal serializer_g0_12: Std_logic;
    signal serializer_g0_i_mb_1: Std_logic;
    signal serializer_g1_15: Std_logic;
    signal serializer_g1_14: Std_logic;
    signal serializer_N_207_0: Std_logic;
    signal serializer_R_tx_phase_7_3: Std_logic;
    signal serializer_R_tx_phase_7_2: Std_logic;
    signal serializer_R_tx_phase_2: Std_logic;
    signal serializer_R_tx_phase_3: Std_logic;
    signal serializer_r_tx_tickcnt12: Std_logic;
    signal serializer_un6_r_tx_tickcnt: Std_logic;
    signal serializer_R_tx_ser_3: Std_logic;
    signal serializer_R_tx_ser_2: Std_logic;
    signal serializer_R_tx_ser_5_2: Std_logic;
    signal serializer_R_tx_ser_5_1: Std_logic;
    signal serializer_R_tx_ser_1_sqmuxa_i: Std_logic;
    signal serializer_R_tx_ser_1: Std_logic;
    signal serializer_R_tx_ser_5: Std_logic;
    signal serializer_R_tx_ser_4: Std_logic;
    signal serializer_R_tx_ser_5_4: Std_logic;
    signal serializer_R_tx_ser_5_3: Std_logic;
    signal serializer_R_tx_ser_7: Std_logic;
    signal serializer_R_tx_ser_6: Std_logic;
    signal serializer_R_tx_ser_5_6: Std_logic;
    signal serializer_R_tx_ser_5_5: Std_logic;
    signal serializer_g0_10_sx: Std_logic;
    signal serializer_g0_10_1: Std_logic;
    signal serializer_R_tx_ser_8: Std_logic;
    signal serializer_R_tx_ser_5_7: Std_logic;
    signal serializer_R_tx_tickcnt_0: Std_logic;
    signal serializer_R_tx_tickcnt_1: Std_logic;
    signal serializer_un1_R_tx_phase_1: Std_logic;
    signal serializer_R_tx_tickcnte_0_1: Std_logic;
    signal serializer_R_tx_tickcnt_e0: Std_logic;
    signal serializer_R_tx_tickcnt_n3: Std_logic;
    signal serializer_R_tx_tickcnt_3: Std_logic;
    signal serializer_R_tx_tickcnt_n2: Std_logic;
    signal serializer_R_tx_tickcnt_2: Std_logic;
    signal serializer_R_tx_tickcnte_0_3: Std_logic;
    signal serializer_R_tx_tickcnte_0_2: Std_logic;
    signal serializer_R_tx_tickcnt_n1: Std_logic;
    signal serializer_R_tx_tickcnt_fast_1: Std_logic;
    signal serializer_R_tx_tickcnt_fast_0: Std_logic;
    signal serializer_R_tx_tickcnte_0_fast_1: Std_logic;
    signal serializer_R_tx_tickcnt_e0_fast: Std_logic;
    signal serializer_R_tx_tickcnt_fast_3: Std_logic;
    signal serializer_R_tx_tickcnt_fast_2: Std_logic;
    signal serializer_R_tx_tickcnte_0_fast_3: Std_logic;
    signal serializer_R_tx_tickcnte_0_fast_2: Std_logic;
    signal serializer_g0_0_7: Std_logic;
    signal serializer_g0_0_6: Std_logic;
    signal serializer_R_debounce_cnt_RNI9JGD2_2: Std_logic;
    signal serializer_un14_r_debounce_cnt_30_10: Std_logic;
    signal serializer_g0_0_5: Std_logic;
    signal serializer_R_tx_ser_5_0: Std_logic;
    signal serializer_g0_3_2: Std_logic;
    signal serializer_R_tx_phase_0_sqmuxa_2: Std_logic;
    signal serializer_g0_0_0: Std_logic;
    signal serializer_g1_0_0: Std_logic;
    signal serializer_un14_r_debounce_cnt_26_4: Std_logic;
    signal serializer_un14_r_debounce_cnt_26_5: Std_logic;
    signal serializer_un14_r_debounce_cnt_30_11: Std_logic;
    signal serializer_g0_1_4_0: Std_logic;
    signal serializer_g0_17_1: Std_logic;
    signal serializer_g0_1_5: Std_logic;
    signal serializer_un14_r_debounce_cnt_30_9: Std_logic;
    signal serializer_g2: Std_logic;
    signal serializer_R_debounce_cnt_RNIQ98L_12: Std_logic;
    signal serializer_R_debounce_cnt_RNIQ98L_0_12: Std_logic;
    signal serializer_R_debounce_cnt_RNI1CNA_30: Std_logic;
    signal serializer_R_debounce_cnt_RNI1TKI2_12: Std_logic;
    signal serializer_g0_0_7_1: Std_logic;
    signal serializer_R_tx_phase_RNO_5_1: Std_logic;
    signal serializer_g0_7: Std_logic;
    signal serializer_R_tx_phase_RNO_4_1: Std_logic;
    signal serializer_R_tx_phase_RNO_2_1: Std_logic;
    signal serializer_g0_0_8: Std_logic;
    signal serializer_g0_0_4_0: Std_logic;
    signal serializer_g0_13_N_6L10_1: Std_logic;
    signal serializer_g0_0_9_0_0: Std_logic;
    signal serializer_R_tx_phase_RNO_3_1: Std_logic;
    signal serializer_g0_1_13: Std_logic;
    signal serializer_g0_1_8: Std_logic;
    signal serializer_g0_1_11: Std_logic;
    signal serializer_g0_1_10: Std_logic;
    signal serializer_g0_1_3: Std_logic;
    signal serializer_g1_14_1: Std_logic;
    signal serializer_g1_7_0: Std_logic;
    signal serializer_g0_2_4: Std_logic;
    signal serializer_g0_1_4: Std_logic;
    signal serializer_g0_0_9: Std_logic;
    signal serializer_g0_1_5_0: Std_logic;
    signal serializer_g1_10: Std_logic;
    signal serializer_g1_9: Std_logic;
    signal serializer_g1_8: Std_logic;
    signal serializer_g1_9_0: Std_logic;
    signal serializer_g1_7_1: Std_logic;
    signal serializer_g1_9_2: Std_logic;
    signal serializer_g1_8_0: Std_logic;
    signal serializer_R_debounce_cnt_RNIQ40E6_23: Std_logic;
    signal serializer_g1_10_0: Std_logic;
    signal serializer_g0_0_sn: Std_logic;
    signal serializer_R_debounce_cnt_RNI6IUF_16: Std_logic;
    signal serializer_R_debounce_cnt_RNI0D2O_10: Std_logic;
    signal GND: Std_logic;
    signal rs232_tx_c: Std_logic;
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
    component rs232_txB
      port (IOLDO: in Std_logic; rs232tx: out Std_logic);
    end component;
    component rs232_tx_MGIOL
      port (IOLDO: out Std_logic; ONEG0: in Std_logic; CE: in Std_logic; 
            CLK: in Std_logic);
    end component;
    component btn_leftB
      port (PADDI: out Std_logic; btnleft: in Std_logic);
    end component;
    component sw_0_B
      port (PADDI: out Std_logic; sw0: in Std_logic);
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
    component led_0_B
      port (PADDO: in Std_logic; led0: out Std_logic);
    end component;
    component clk_25mB
      port (PADDI: out Std_logic; clk25m: in Std_logic);
    end component;
    component btn_centerB
      port (PADDI: out Std_logic; btncenter: in Std_logic);
    end component;
    component btn_downB
      port (PADDI: out Std_logic; btndown: in Std_logic);
    end component;
    component btn_upB
      port (PADDI: out Std_logic; btnup: in Std_logic);
    end component;
    component btn_rightB
      port (PADDI: out Std_logic; btnright: in Std_logic);
    end component;
  begin
    serializer_SLICE_0I: SCCU2B
      generic map (CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   INIT0_INITVAL=>"0x0000", INIT1_INITVAL=>"0x33CC")
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_0, C1=>'X', 
                D1=>serializer_VCC, DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', 
                C0=>'X', D0=>'X', FCI=>'X', M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', FCO=>serializer_un1_R_debounce_cnt_3_cry_0_s1, 
                F1=>open, Q1=>open, F0=>open, Q0=>open);
    serializer_SLICE_1I: SCCU2B
      generic map (CCU2_INJECT1_1=>"NO", INIT0_INITVAL=>"0x6636", 
                   INIT1_INITVAL=>"0xFF00")
      port map (M1=>'X', A1=>'X', B1=>'X', C1=>'X', D1=>serializer_VCC, 
                DI1=>'X', DI0=>'X', A0=>sw_c_0, B0=>serializer_R_byte_old_6, 
                C0=>serializer_a_1_i_a2_0_0_7, D0=>btn_center_c, 
                FCI=>serializer_un1_byte_in_0_data_tmp_2, M0=>'X', CE=>'X', 
                CLK=>'X', LSR=>'X', FCO=>open, F1=>serializer_un1_byte_in_i, 
                Q1=>open, F0=>open, Q0=>open);
    serializer_SLICE_2I: SCCU2B
      generic map (INIT0_INITVAL=>"0x8241", INIT1_INITVAL=>"0x8421")
      port map (M1=>'X', A1=>led_c_5, B1=>serializer_R_byte_old_4, 
                C1=>serializer_R_byte_old_5, D1=>led_c_4, DI1=>'X', DI0=>'X', 
                A0=>led_c_3, B0=>serializer_R_byte_old_2, C0=>led_c_2, 
                D0=>serializer_R_byte_old_3, 
                FCI=>serializer_un1_byte_in_0_data_tmp_0, M0=>'X', CE=>'X', 
                CLK=>'X', LSR=>'X', FCO=>serializer_un1_byte_in_0_data_tmp_2, 
                F1=>open, Q1=>open, F0=>open, Q0=>open);
    serializer_SLICE_3I: SCCU2B
      generic map (CCU2_INJECT1_0=>"NO", INIT0_INITVAL=>"0x00FF", 
                   INIT1_INITVAL=>"0x9009")
      port map (M1=>'X', A1=>serializer_R_byte_old_1, B1=>led_c_1, C1=>led_c_0, 
                D1=>serializer_R_byte_old_0, DI1=>'X', DI0=>'X', A0=>'X', 
                B0=>'X', C0=>'X', D0=>serializer_VCC, FCI=>'X', M0=>'X', 
                CE=>'X', CLK=>'X', LSR=>'X', 
                FCO=>serializer_un1_byte_in_0_data_tmp_0, F1=>open, Q1=>open, 
                F0=>open, Q0=>open);
    serializer_SLICE_4I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xAA00", 
                   INIT1_INITVAL=>"0x0000", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>'X', C1=>'X', D1=>'X', 
                DI1=>serializer_un4_r_baudgen_16, 
                DI0=>serializer_un4_r_baudgen_15, A0=>serializer_R_baudgen_15, 
                B0=>'X', C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_14, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>open, 
                F1=>serializer_un4_r_baudgen_16, Q1=>serializer_R_baudgen_16, 
                F0=>serializer_un4_r_baudgen_15, Q0=>serializer_R_baudgen_15);
    serializer_SLICE_5I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_14, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un4_r_baudgen_14, 
                DI0=>serializer_un4_r_baudgen_13, A0=>'X', 
                B0=>serializer_R_baudgen_13, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_12, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_14, 
                F1=>serializer_un4_r_baudgen_14, Q1=>serializer_R_baudgen_14, 
                F0=>serializer_un4_r_baudgen_13, Q0=>serializer_R_baudgen_13);
    serializer_SLICE_6I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0x33CC", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_12, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un4_r_baudgen_12, 
                DI0=>serializer_un4_r_baudgen_11, A0=>'X', 
                B0=>serializer_R_baudgen_11, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_10, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_12, 
                F1=>serializer_un4_r_baudgen_12, Q1=>serializer_R_baudgen_12, 
                F0=>serializer_un4_r_baudgen_11, Q0=>serializer_R_baudgen_11);
    serializer_SLICE_7I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0x55AA", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_10, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un4_r_baudgen_10, 
                DI0=>serializer_un4_r_baudgen_9, A0=>serializer_R_baudgen_9, 
                B0=>'X', C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_8, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_10, 
                F1=>serializer_un4_r_baudgen_10, Q1=>serializer_R_baudgen_10, 
                F0=>serializer_un4_r_baudgen_9, Q0=>serializer_R_baudgen_9);
    serializer_SLICE_8I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0x33CC", 
                   INIT1_INITVAL=>"0xCC00", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_8, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un4_r_baudgen_8, 
                DI0=>serializer_un4_r_baudgen_7, A0=>'X', 
                B0=>serializer_R_baudgen_7, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_6, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_8, 
                F1=>serializer_un4_r_baudgen_8, Q1=>serializer_R_baudgen_8, 
                F0=>serializer_un4_r_baudgen_7, Q0=>serializer_R_baudgen_7);
    serializer_SLICE_9I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0xCC00", 
                   INIT1_INITVAL=>"0x33CC", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_6, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un4_r_baudgen_6, 
                DI0=>serializer_un4_r_baudgen_5, A0=>'X', 
                B0=>serializer_R_baudgen_5, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_4, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_6, 
                F1=>serializer_un4_r_baudgen_6, Q1=>serializer_R_baudgen_6, 
                F0=>serializer_un4_r_baudgen_5, Q0=>serializer_R_baudgen_5);
    serializer_SLICE_10I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0x55AA", 
                   INIT1_INITVAL=>"0x33CC", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_4, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un4_r_baudgen_4, 
                DI0=>serializer_un4_r_baudgen_3, A0=>serializer_R_baudgen_3, 
                B0=>'X', C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_2, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_4, 
                F1=>serializer_un4_r_baudgen_4, Q1=>serializer_R_baudgen_4, 
                F0=>serializer_un4_r_baudgen_3, Q0=>serializer_R_baudgen_3);
    serializer_SLICE_11I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", CCU2_INJECT1_0=>"NO", 
                   CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", INIT0_INITVAL=>"0x33CC", 
                   INIT1_INITVAL=>"0x33CC", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_2, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un4_r_baudgen_2, 
                DI0=>serializer_un4_r_baudgen_1, A0=>'X', 
                B0=>serializer_R_baudgen_1, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un4_r_baudgen_cry_0, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_2, 
                F1=>serializer_un4_r_baudgen_2, Q1=>serializer_R_baudgen_2, 
                F0=>serializer_un4_r_baudgen_1, Q0=>serializer_R_baudgen_1);
    serializer_SLICE_12I: SCCU2B
      generic map (CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   INIT0_INITVAL=>"0x0000", INIT1_INITVAL=>"0x33CC")
      port map (M1=>'X', A1=>'X', B1=>serializer_R_baudgen_0, C1=>'X', 
                D1=>serializer_VCC, DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', 
                C0=>'X', D0=>'X', FCI=>'X', M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', FCO=>serializer_un4_r_baudgen_cry_0, F1=>open, 
                Q1=>open, F0=>open, Q0=>open);
    serializer_SLICE_13I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x3300", INIT1_INITVAL=>"0x0000", 
                   REG0_SD=>"VHI", CHECK_DI0=>TRUE, CHECK_CE=>TRUE, 
                   CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>'X', C1=>'X', D1=>'X', DI1=>'X', 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_0, A0=>'X', 
                B0=>serializer_R_debounce_cnt_31, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_30_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, FCO=>open, F1=>open, Q1=>open, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_0, 
                Q0=>serializer_R_debounce_cnt_31);
    serializer_SLICE_14I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_30, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_1, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_2, A0=>'X', 
                B0=>serializer_R_debounce_cnt_29, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_28_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_30_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_1, 
                Q1=>serializer_R_debounce_cnt_30, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_2, 
                Q0=>serializer_R_debounce_cnt_29);
    serializer_SLICE_15I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_28, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_3, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_4, 
                A0=>serializer_R_debounce_cnt_27, B0=>'X', C0=>'X', 
                D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_26_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_28_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_3, 
                Q1=>serializer_R_debounce_cnt_28, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_4, 
                Q0=>serializer_R_debounce_cnt_27);
    serializer_SLICE_16I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_26, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_5, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_6, A0=>'X', 
                B0=>serializer_R_debounce_cnt_25, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_24_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_26_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_5, 
                Q1=>serializer_R_debounce_cnt_26, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_6, 
                Q0=>serializer_R_debounce_cnt_25);
    serializer_SLICE_17I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_24, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_7, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_8, A0=>'X', 
                B0=>serializer_R_debounce_cnt_23, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_22_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_24_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_7, 
                Q1=>serializer_R_debounce_cnt_24, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_8, 
                Q0=>serializer_R_debounce_cnt_23);
    serializer_SLICE_18I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_22, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_9, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_10, 
                A0=>serializer_R_debounce_cnt_21, B0=>'X', C0=>'X', 
                D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_20_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_22_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_9, 
                Q1=>serializer_R_debounce_cnt_22, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_10, 
                Q0=>serializer_R_debounce_cnt_21);
    serializer_SLICE_19I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_20, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_11, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_12, A0=>'X', 
                B0=>serializer_R_debounce_cnt_19, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_18_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_20_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_11, 
                Q1=>serializer_R_debounce_cnt_20, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_12, 
                Q0=>serializer_R_debounce_cnt_19);
    serializer_SLICE_20I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG0_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_18, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_13, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_14, A0=>'X', 
                B0=>serializer_R_debounce_cnt_17, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_16_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_18_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_13, 
                Q1=>serializer_R_debounce_cnt_18, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_14, 
                Q0=>serializer_R_debounce_cnt_17);
    serializer_SLICE_21I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_16, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_15, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_16, 
                A0=>serializer_R_debounce_cnt_15, B0=>'X', C0=>'X', 
                D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_14_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_16_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_15, 
                Q1=>serializer_R_debounce_cnt_16, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_16, 
                Q0=>serializer_R_debounce_cnt_15);
    serializer_SLICE_22I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_14, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_17, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_18, A0=>'X', 
                B0=>serializer_R_debounce_cnt_13, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_12_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_14_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_17, 
                Q1=>serializer_R_debounce_cnt_14, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_18, 
                Q0=>serializer_R_debounce_cnt_13);
    serializer_SLICE_23I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_12, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_19, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_20, A0=>'X', 
                B0=>serializer_R_debounce_cnt_11, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_10_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_12_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_19, 
                Q1=>serializer_R_debounce_cnt_12, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_20, 
                Q0=>serializer_R_debounce_cnt_11);
    serializer_SLICE_24I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG0_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_10, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_21, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_22, 
                A0=>serializer_R_debounce_cnt_9, B0=>'X', C0=>'X', 
                D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_8_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_10_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_21, 
                Q1=>serializer_R_debounce_cnt_10, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_22, 
                Q0=>serializer_R_debounce_cnt_9);
    serializer_SLICE_25I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG0_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_8, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_23, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_24, A0=>'X', 
                B0=>serializer_R_debounce_cnt_7, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_6_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_8_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_23, 
                Q1=>serializer_R_debounce_cnt_8, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_24, 
                Q0=>serializer_R_debounce_cnt_7);
    serializer_SLICE_26I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_6, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_25, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_26, A0=>'X', 
                B0=>serializer_R_debounce_cnt_5, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_4_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_6_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_25, 
                Q1=>serializer_R_debounce_cnt_6, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_26, 
                Q0=>serializer_R_debounce_cnt_5);
    serializer_SLICE_27I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x55AA", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_4, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_27, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_28, 
                A0=>serializer_R_debounce_cnt_3, B0=>'X', C0=>'X', 
                D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_2_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_4_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_27, 
                Q1=>serializer_R_debounce_cnt_4, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_28, 
                Q0=>serializer_R_debounce_cnt_3);
    serializer_SLICE_28I: SCCU2B
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", LSRMUX=>"SIG", 
                   CCU2_INJECT1_0=>"NO", CCU2_INJECT1_1=>"NO", GSR=>"DISABLED", 
                   INIT0_INITVAL=>"0x33CC", INIT1_INITVAL=>"0x33CC", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_CE=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', A1=>'X', B1=>serializer_R_debounce_cnt_2, C1=>'X', 
                D1=>serializer_VCC, DI1=>serializer_un1_R_debounce_cnt_3_s1_29, 
                DI0=>serializer_un1_R_debounce_cnt_3_s1_30, A0=>'X', 
                B0=>serializer_R_debounce_cnt_1, C0=>'X', D0=>serializer_VCC, 
                FCI=>serializer_un1_R_debounce_cnt_3_cry_0_s1, M0=>'X', 
                CE=>serializer_un1_R_debounce_cnt_1_i, CLK=>clk_25m_c, 
                LSR=>serializer_un1_byte_in_i, 
                FCO=>serializer_un1_R_debounce_cnt_3_cry_2_s1, 
                F1=>serializer_un1_R_debounce_cnt_3_s1_29, 
                Q1=>serializer_R_debounce_cnt_2, 
                F0=>serializer_un1_R_debounce_cnt_3_s1_30, 
                Q0=>serializer_R_debounce_cnt_1);
    serializer_SLICE_29I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"00FF", 
                   REG0_SD=>"VHI", CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>serializer_R_baudgen_i_0, A0=>'X', 
                B0=>'X', C0=>'X', D0=>serializer_R_baudgen_0, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', OFX1=>open, F1=>open, Q1=>open, 
                OFX0=>open, F0=>serializer_R_baudgen_i_0, 
                Q0=>serializer_R_baudgen_0);
    serializer_SLICE_30I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"3F2E", 
                   LUT1_INITVAL=>X"FCB8", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>btn_up_c, B1=>sw_c_0, 
                C1=>serializer_a_6, D1=>btn_center_c, DI1=>led_c_2, 
                DI0=>led_c_0, A0=>btn_right_c, B0=>sw_c_0, 
                C0=>modul_brojke_N_17, D0=>btn_center_c, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', OFX1=>open, F1=>led_c_2, 
                Q1=>serializer_R_byte_old_2, OFX0=>open, F0=>led_c_0, 
                Q0=>serializer_R_byte_old_0);
    serializer_SLICE_31I: SLOGICB
      generic map (M0MUX=>"SIG", CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"FFFE", 
                   LUT1_INITVAL=>X"00FB", REG0_SD=>"VHI", CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>btn_up_c, B1=>btn_down_c, 
                C1=>btn_right_c, D1=>modul_brojke_N_19, DI1=>'X', DI0=>led_c_1, 
                A0=>btn_up_c, B0=>btn_center_c, C0=>serializer_N_24, 
                D0=>btn_left_c, M0=>sw_c_0, CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>led_c_1, F0=>open, 
                Q0=>serializer_R_byte_old_1);
    serializer_SLICE_32I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"3330", 
                   LUT1_INITVAL=>X"FC74", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_a_1_i_a2_0_0_7, 
                B1=>sw_c_0, C1=>btn_up_c, D1=>btn_center_c, DI1=>led_c_4, 
                DI0=>led_c_3, A0=>'X', B0=>sw_c_0, C0=>btn_right_c, 
                D0=>btn_center_c, M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>led_c_4, Q1=>serializer_R_byte_old_4, 
                OFX0=>open, F0=>led_c_3, Q0=>serializer_R_byte_old_3);
    serializer_SLICE_33I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"30FF", 
                   LUT1_INITVAL=>X"5511", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>sw_c_0, 
                B1=>serializer_a_1_i_a2_0_0_7, C1=>'X', D1=>btn_center_c, 
                DI1=>led_c_6, DI0=>led_c_5, A0=>'X', 
                B0=>serializer_a_1_i_a2_0_0_7, C0=>sw_c_0, D0=>serializer_N_7, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', OFX1=>open, 
                F1=>led_c_6, Q1=>serializer_R_byte_old_6, OFX0=>open, 
                F0=>led_c_5, Q0=>serializer_R_byte_old_5);
    serializer_SLICE_34I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", GSR=>"DISABLED", 
                   LUT0_INITVAL=>X"8877", LUT1_INITVAL=>X"A000", 
                   REG0_SD=>"VHI", CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g0_3_4, B1=>'X', 
                C1=>serializer_g0_3_5, D1=>serializer_g0_3_6, DI1=>'X', 
                DI0=>serializer_un1_R_debounce_cnt_3_31, 
                A0=>serializer_un14_r_debounce_cnt_30, 
                B0=>serializer_un1_R_debounce_cnt_1_3, C0=>'X', 
                D0=>serializer_R_debounce_cnt_0, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>serializer_un1_byte_in_i, OFX1=>open, 
                F1=>serializer_un1_R_debounce_cnt_1_3, Q1=>open, OFX0=>open, 
                F0=>serializer_un1_R_debounce_cnt_3_31, 
                Q0=>serializer_R_debounce_cnt_0);
    serializer_SLICE_35I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", GSR=>"DISABLED", 
                   LUT0_INITVAL=>X"55EA", LUT1_INITVAL=>X"3C44", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', 
                A1=>serializer_un14_r_debounce_cnt_0_0, 
                B1=>serializer_R_tx_phase_1, C1=>serializer_R_tx_phase_0, 
                D1=>serializer_R_tx_ser_0_sqmuxa, 
                DI1=>serializer_R_tx_phase_7_1, DI0=>serializer_R_tx_phase_7_0, 
                A0=>serializer_R_tx_ser_0_sqmuxa, B0=>serializer_g0_0_15, 
                C0=>serializer_g0_0_14, D0=>serializer_R_tx_phase_0, M0=>'X', 
                CE=>'X', CLK=>clk_25m_c, LSR=>serializer_R_tx_phase_0_sqmuxa, 
                OFX1=>open, F1=>serializer_R_tx_phase_7_1, 
                Q1=>serializer_R_tx_phase_1, OFX0=>open, 
                F0=>serializer_R_tx_phase_7_0, Q0=>serializer_R_tx_phase_0);
    serializer_SLICE_36I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", LSRMUX=>"SIG", GSR=>"DISABLED", 
                   LUT0_INITVAL=>X"AAA8", LUT1_INITVAL=>X"AA2A", 
                   REG1_SD=>"VHI", REG0_SD=>"VHI", CHECK_DI1=>TRUE, 
                   CHECK_DI0=>TRUE, CHECK_LSR=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g0_i_mb_1, 
                B1=>serializer_g0_12, C1=>serializer_g0_11, 
                D1=>serializer_R_tx_ser_0_sqmuxa, 
                DI1=>serializer_R_tx_phase_7_3, DI0=>serializer_R_tx_phase_7_2, 
                A0=>serializer_N_207_0, B0=>serializer_g1_14, 
                C0=>serializer_g1_15, D0=>serializer_R_tx_ser_0_sqmuxa, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, 
                LSR=>serializer_R_tx_phase_0_sqmuxa, OFX1=>open, 
                F1=>serializer_R_tx_phase_7_3, Q1=>serializer_R_tx_phase_3, 
                OFX0=>open, F0=>serializer_R_tx_phase_7_2, 
                Q0=>serializer_R_tx_phase_2);
    serializer_SLICE_37I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", REG0_REGSET=>"SET", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", LUT0_INITVAL=>X"B8F0", 
                   LUT1_INITVAL=>X"B8F0", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE, CHECK_CE=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_tx_ser_3, 
                B1=>serializer_un6_r_tx_tickcnt, C1=>serializer_R_byte_old_1, 
                D1=>serializer_r_tx_tickcnt12, DI1=>serializer_R_tx_ser_5_2, 
                DI0=>serializer_R_tx_ser_5_1, A0=>serializer_R_tx_ser_2, 
                B0=>serializer_un6_r_tx_tickcnt, C0=>serializer_R_byte_old_0, 
                D0=>serializer_r_tx_tickcnt12, M0=>'X', 
                CE=>serializer_R_tx_ser_1_sqmuxa_i, CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>serializer_R_tx_ser_5_2, 
                Q1=>serializer_R_tx_ser_2, OFX0=>open, 
                F0=>serializer_R_tx_ser_5_1, Q0=>serializer_R_tx_ser_1);
    serializer_SLICE_38I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", REG0_REGSET=>"SET", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", LUT0_INITVAL=>X"E4CC", 
                   LUT1_INITVAL=>X"DF80", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE, CHECK_CE=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_r_tx_tickcnt12, 
                B1=>serializer_R_tx_ser_5, C1=>serializer_un6_r_tx_tickcnt, 
                D1=>serializer_R_byte_old_3, DI1=>serializer_R_tx_ser_5_4, 
                DI0=>serializer_R_tx_ser_5_3, A0=>serializer_un6_r_tx_tickcnt, 
                B0=>serializer_R_byte_old_2, C0=>serializer_R_tx_ser_4, 
                D0=>serializer_r_tx_tickcnt12, M0=>'X', 
                CE=>serializer_R_tx_ser_1_sqmuxa_i, CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>serializer_R_tx_ser_5_4, 
                Q1=>serializer_R_tx_ser_4, OFX0=>open, 
                F0=>serializer_R_tx_ser_5_3, Q0=>serializer_R_tx_ser_3);
    serializer_SLICE_39I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", REG0_REGSET=>"SET", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", LUT0_INITVAL=>X"F780", 
                   LUT1_INITVAL=>X"F870", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE, CHECK_CE=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_r_tx_tickcnt12, 
                B1=>serializer_un6_r_tx_tickcnt, C1=>serializer_R_byte_old_5, 
                D1=>serializer_R_tx_ser_7, DI1=>serializer_R_tx_ser_5_6, 
                DI0=>serializer_R_tx_ser_5_5, A0=>serializer_r_tx_tickcnt12, 
                B0=>serializer_un6_r_tx_tickcnt, C0=>serializer_R_tx_ser_6, 
                D0=>serializer_R_byte_old_4, M0=>'X', 
                CE=>serializer_R_tx_ser_1_sqmuxa_i, CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>serializer_R_tx_ser_5_6, 
                Q1=>serializer_R_tx_ser_6, OFX0=>open, 
                F0=>serializer_R_tx_ser_5_5, Q0=>serializer_R_tx_ser_5);
    serializer_SLICE_40I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"SIG", REG0_REGSET=>"SET", 
                   REG1_REGSET=>"SET", GSR=>"DISABLED", SRMODE=>"ASYNC", 
                   LSRONMUX=>"OFF", LUT0_INITVAL=>X"EA2A", 
                   LUT1_INITVAL=>X"0C04", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE, CHECK_CE=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g0_10_1, 
                B1=>serializer_R_baudgen_16, C1=>serializer_g0_10_sx, 
                D1=>serializer_R_tx_phase_0, DI1=>serializer_R_tx_ser_0_sqmuxa, 
                DI0=>serializer_R_tx_ser_5_7, A0=>serializer_R_byte_old_6, 
                B0=>serializer_r_tx_tickcnt12, C0=>serializer_un6_r_tx_tickcnt, 
                D0=>serializer_R_tx_ser_8, M0=>'X', 
                CE=>serializer_R_tx_ser_1_sqmuxa_i, CLK=>clk_25m_c, LSR=>'X', 
                OFX1=>open, F1=>serializer_R_tx_ser_0_sqmuxa, 
                Q1=>serializer_R_tx_ser_8, OFX0=>open, 
                F0=>serializer_R_tx_ser_5_7, Q0=>serializer_R_tx_ser_7);
    serializer_SLICE_41I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"AF50", 
                   LUT1_INITVAL=>X"9CCC", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_un1_R_tx_phase_1, 
                B1=>serializer_R_tx_tickcnt_1, C1=>serializer_R_baudgen_16, 
                D1=>serializer_R_tx_tickcnt_0, 
                DI1=>serializer_R_tx_tickcnte_0_1, 
                DI0=>serializer_R_tx_tickcnt_e0, 
                A0=>serializer_un1_R_tx_phase_1, B0=>'X', 
                C0=>serializer_R_baudgen_16, D0=>serializer_R_tx_tickcnt_0, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', OFX1=>open, 
                F1=>serializer_R_tx_tickcnte_0_1, 
                Q1=>serializer_R_tx_tickcnt_1, OFX0=>open, 
                F0=>serializer_R_tx_tickcnt_e0, Q0=>serializer_R_tx_tickcnt_0);
    serializer_SLICE_42I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"BA8A", 
                   LUT1_INITVAL=>X"F2D0", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_baudgen_16, 
                B1=>serializer_un1_R_tx_phase_1, C1=>serializer_R_tx_tickcnt_3, 
                D1=>serializer_R_tx_tickcnt_n3, 
                DI1=>serializer_R_tx_tickcnte_0_3, 
                DI0=>serializer_R_tx_tickcnte_0_2, 
                A0=>serializer_R_tx_tickcnt_2, B0=>serializer_un1_R_tx_phase_1, 
                C0=>serializer_R_baudgen_16, D0=>serializer_R_tx_tickcnt_n2, 
                M0=>'X', CE=>'X', CLK=>clk_25m_c, LSR=>'X', OFX1=>open, 
                F1=>serializer_R_tx_tickcnte_0_3, 
                Q1=>serializer_R_tx_tickcnt_3, OFX0=>open, 
                F0=>serializer_R_tx_tickcnte_0_2, 
                Q0=>serializer_R_tx_tickcnt_2);
    serializer_SLICE_43I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"AF50", 
                   LUT1_INITVAL=>X"DC8C", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_un1_R_tx_phase_1, 
                B1=>serializer_R_tx_tickcnt_fast_1, 
                C1=>serializer_R_baudgen_16, D1=>serializer_R_tx_tickcnt_n1, 
                DI1=>serializer_R_tx_tickcnte_0_fast_1, 
                DI0=>serializer_R_tx_tickcnt_e0_fast, 
                A0=>serializer_un1_R_tx_phase_1, B0=>'X', 
                C0=>serializer_R_baudgen_16, 
                D0=>serializer_R_tx_tickcnt_fast_0, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', OFX1=>open, 
                F1=>serializer_R_tx_tickcnte_0_fast_1, 
                Q1=>serializer_R_tx_tickcnt_fast_1, OFX0=>open, 
                F0=>serializer_R_tx_tickcnt_e0_fast, 
                Q0=>serializer_R_tx_tickcnt_fast_0);
    serializer_SLICE_44I: SLOGICB
      generic map (CLKMUX=>"SIG", CEMUX=>"VHI", GSR=>"DISABLED", 
                   SRMODE=>"ASYNC", LSRONMUX=>"OFF", LUT0_INITVAL=>X"FB40", 
                   LUT1_INITVAL=>X"F4B0", REG1_SD=>"VHI", REG0_SD=>"VHI", 
                   CHECK_DI1=>TRUE, CHECK_DI0=>TRUE)
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_un1_R_tx_phase_1, 
                B1=>serializer_R_baudgen_16, 
                C1=>serializer_R_tx_tickcnt_fast_3, 
                D1=>serializer_R_tx_tickcnt_n3, 
                DI1=>serializer_R_tx_tickcnte_0_fast_3, 
                DI0=>serializer_R_tx_tickcnte_0_fast_2, 
                A0=>serializer_un1_R_tx_phase_1, B0=>serializer_R_baudgen_16, 
                C0=>serializer_R_tx_tickcnt_n2, 
                D0=>serializer_R_tx_tickcnt_fast_2, M0=>'X', CE=>'X', 
                CLK=>clk_25m_c, LSR=>'X', OFX1=>open, 
                F1=>serializer_R_tx_tickcnte_0_fast_3, 
                Q1=>serializer_R_tx_tickcnt_fast_3, OFX0=>open, 
                F0=>serializer_R_tx_tickcnte_0_fast_2, 
                Q0=>serializer_R_tx_tickcnt_fast_2);
    serializer_SLICE_45I: SLOGICB
      generic map (LUT0_INITVAL=>X"0200", LUT1_INITVAL=>X"7FFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', 
                A1=>serializer_R_debounce_cnt_RNI9JGD2_2, 
                B1=>serializer_g0_3_6, C1=>serializer_g0_0_6, 
                D1=>serializer_g0_0_7, DI1=>'X', DI0=>'X', 
                A0=>serializer_g0_0_5, B0=>serializer_R_debounce_cnt_20, 
                C0=>serializer_R_debounce_cnt_21, 
                D0=>serializer_un14_r_debounce_cnt_30_10, M0=>'X', CE=>'X', 
                CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>serializer_un1_R_debounce_cnt_1_i, Q1=>open, OFX0=>open, 
                F0=>serializer_g0_0_7, Q0=>open);
    serializer_SLICE_46I: SLOGICB
      generic map (LUT0_INITVAL=>X"0080", LUT1_INITVAL=>X"0001")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_tx_phase_2, 
                B1=>serializer_R_tx_phase_1, C1=>serializer_R_tx_phase_3, 
                D1=>serializer_R_tx_phase_0, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_tx_ser_1, B0=>serializer_R_baudgen_16, 
                C0=>serializer_un6_r_tx_tickcnt, 
                D0=>serializer_un1_R_tx_phase_1, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_un1_R_tx_phase_1, 
                Q1=>open, OFX0=>open, F0=>serializer_R_tx_ser_5_0, Q0=>open);
    serializer_SLICE_47I: SLOGICB
      generic map (LUT0_INITVAL=>X"8000", LUT1_INITVAL=>X"3CF0")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>serializer_g0_3_2, 
                C1=>serializer_R_tx_phase_3, D1=>serializer_un6_r_tx_tickcnt, 
                DI1=>'X', DI0=>'X', A0=>serializer_R_tx_tickcnt_fast_3, 
                B0=>serializer_R_tx_tickcnt_fast_1, 
                C0=>serializer_R_tx_tickcnt_fast_2, 
                D0=>serializer_R_tx_tickcnt_fast_0, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_i_mb_1, Q1=>open, 
                OFX0=>open, F0=>serializer_un6_r_tx_tickcnt, Q0=>open);
    serializer_SLICE_48I: SLOGICB
      generic map (LUT0_INITVAL=>X"1000", LUT1_INITVAL=>X"8800")
      port map (M1=>'X', FXA=>'X', FXB=>'X', 
                A1=>serializer_R_tx_phase_0_sqmuxa_2, 
                B1=>serializer_R_baudgen_16, C1=>'X', 
                D1=>serializer_un6_r_tx_tickcnt, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_tx_phase_0, B0=>serializer_R_tx_phase_2, 
                C0=>serializer_R_tx_phase_3, D0=>serializer_R_tx_phase_1, 
                M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>serializer_R_tx_phase_0_sqmuxa, Q1=>open, OFX0=>open, 
                F0=>serializer_R_tx_phase_0_sqmuxa_2, Q0=>open);
    serializer_SLICE_49I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"8000")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g0_0_0, 
                B1=>serializer_g0_0_5, 
                C1=>serializer_un14_r_debounce_cnt_30_10, 
                D1=>serializer_g0_0_6, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_29, 
                B0=>serializer_R_debounce_cnt_30, 
                C0=>serializer_R_debounce_cnt_27, 
                D0=>serializer_R_debounce_cnt_28, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_un14_r_debounce_cnt_30, 
                Q1=>open, OFX0=>open, F0=>serializer_un14_r_debounce_cnt_30_10, 
                Q0=>open);
    serializer_SLICE_50I: SLOGICB
      generic map (LUT0_INITVAL=>X"6CCC", LUT1_INITVAL=>X"AA00")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_tx_phase_1, 
                B1=>'X', C1=>'X', D1=>serializer_R_tx_phase_0, DI1=>'X', 
                DI0=>'X', A0=>serializer_g1_0_0, B0=>serializer_R_tx_phase_2, 
                C0=>serializer_un6_r_tx_tickcnt, D0=>serializer_R_baudgen_16, 
                M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>serializer_g1_0_0, Q1=>open, OFX0=>open, 
                F0=>serializer_N_207_0, Q0=>open);
    serializer_SLICE_51I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0300")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', 
                B1=>serializer_R_debounce_cnt_2, 
                C1=>serializer_R_debounce_cnt_3, 
                D1=>serializer_un14_r_debounce_cnt_26_4, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_13, 
                B0=>serializer_R_debounce_cnt_15, 
                C0=>serializer_R_debounce_cnt_14, 
                D0=>serializer_R_debounce_cnt_12, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_3_4, Q1=>open, 
                OFX0=>open, F0=>serializer_un14_r_debounce_cnt_26_4, Q0=>open);
    serializer_SLICE_52I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"3FFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>serializer_g0_1_4_0, 
                C1=>serializer_un14_r_debounce_cnt_30_11, 
                D1=>serializer_un14_r_debounce_cnt_26_5, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_7, 
                B0=>serializer_R_debounce_cnt_6, 
                C0=>serializer_R_debounce_cnt_4, 
                D0=>serializer_R_debounce_cnt_5, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_17_1, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_1_4_0, Q0=>open);
    serializer_SLICE_53I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"2000")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g2, 
                B1=>serializer_g0_17_1, 
                C1=>serializer_un14_r_debounce_cnt_30_9, D1=>serializer_g0_1_5, 
                DI1=>'X', DI0=>'X', A0=>serializer_R_debounce_cnt_15, 
                B0=>serializer_R_debounce_cnt_12, 
                C0=>serializer_R_debounce_cnt_14, 
                D0=>serializer_R_debounce_cnt_13, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_12, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_1_5, Q0=>open);
    serializer_SLICE_54I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0200")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g0_3_5, 
                B1=>serializer_R_debounce_cnt_2, 
                C1=>serializer_R_debounce_cnt_3, 
                D1=>serializer_R_debounce_cnt_RNIQ98L_12, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_7, 
                B0=>serializer_R_debounce_cnt_6, 
                C0=>serializer_R_debounce_cnt_0, 
                D0=>serializer_R_debounce_cnt_1, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_debounce_cnt_RNI9JGD2_2, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_3_5, Q0=>open);
    serializer_SLICE_55I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"7FFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', 
                A1=>serializer_R_debounce_cnt_RNI1CNA_30, 
                B1=>serializer_un14_r_debounce_cnt_30_9, 
                C1=>serializer_R_debounce_cnt_RNIQ98L_0_12, 
                D1=>serializer_un14_r_debounce_cnt_26_5, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_10, 
                B0=>serializer_R_debounce_cnt_11, 
                C0=>serializer_R_debounce_cnt_9, 
                D0=>serializer_R_debounce_cnt_8, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, 
                F1=>serializer_R_debounce_cnt_RNI1TKI2_12, Q1=>open, 
                OFX0=>open, F0=>serializer_un14_r_debounce_cnt_26_5, Q0=>open);
    serializer_SLICE_56I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"7FFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_tx_phase_RNO_4_1, 
                B1=>serializer_g0_7, C1=>serializer_R_tx_phase_RNO_5_1, 
                D1=>serializer_g0_0_7_1, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_10, 
                B0=>serializer_R_debounce_cnt_8, 
                C0=>serializer_R_debounce_cnt_11, 
                D0=>serializer_R_debounce_cnt_9, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_tx_phase_RNO_2_1, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_0_7_1, Q0=>open);
    serializer_SLICE_57I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0050")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_22, 
                B1=>'X', C1=>serializer_g0_0_8, 
                D1=>serializer_R_debounce_cnt_28, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_31, 
                B0=>serializer_R_debounce_cnt_14, 
                C0=>serializer_R_debounce_cnt_15, 
                D0=>serializer_R_debounce_cnt_7, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_0_4_0, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_0_8, Q0=>open);
    serializer_SLICE_58I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0020")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g0_0_9_0_0, 
                B1=>serializer_R_debounce_cnt_25, 
                C1=>serializer_g0_13_N_6L10_1, 
                D1=>serializer_R_debounce_cnt_26, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_13, 
                B0=>serializer_R_debounce_cnt_12, 
                C0=>serializer_R_debounce_cnt_4, 
                D0=>serializer_R_debounce_cnt_5, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_tx_phase_RNO_3_1, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_0_9_0_0, Q0=>open);
    serializer_SLICE_59I: SLOGICB
      generic map (LUT0_INITVAL=>X"8000", LUT1_INITVAL=>X"0001")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_30, 
                B1=>serializer_R_debounce_cnt_29, 
                C1=>serializer_R_debounce_cnt_27, 
                D1=>serializer_R_debounce_cnt_1, DI1=>'X', DI0=>'X', 
                A0=>serializer_g0_1_11, B0=>serializer_g0_7, 
                C0=>serializer_g0_1_8, D0=>serializer_g0_1_13, M0=>'X', 
                CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, F1=>serializer_g0_7, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_0_14, Q0=>open);
    serializer_SLICE_60I: SLOGICB
      generic map (LUT0_INITVAL=>X"0040", LUT1_INITVAL=>X"0303")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', 
                B1=>serializer_R_debounce_cnt_24, 
                C1=>serializer_R_debounce_cnt_23, D1=>'X', DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_25, B0=>serializer_g0_1_3, 
                C0=>serializer_g0_1_10, D0=>serializer_R_debounce_cnt_26, 
                M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>serializer_g0_1_3, Q1=>open, OFX0=>open, 
                F0=>serializer_g0_1_13, Q0=>open);
    serializer_SLICE_61I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"DFFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g2, 
                B1=>serializer_g1_7_0, C1=>serializer_g1_14_1, 
                D1=>serializer_un14_r_debounce_cnt_30_9, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_16, 
                B0=>serializer_R_debounce_cnt_18, 
                C0=>serializer_R_debounce_cnt_19, 
                D0=>serializer_R_debounce_cnt_17, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g1_14, Q1=>open, 
                OFX0=>open, F0=>serializer_un14_r_debounce_cnt_30_9, Q0=>open);
    serializer_SLICE_62I: SLOGICB
      generic map (LUT0_INITVAL=>X"8000", LUT1_INITVAL=>X"FFFE")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_byte_old_6, 
                B1=>serializer_R_byte_old_4, C1=>serializer_R_byte_old_2, 
                D1=>serializer_g0_2_4, DI1=>'X', DI0=>'X', 
                A0=>serializer_g0_0_7_1, B0=>serializer_g2, 
                C0=>serializer_g0_0_8, D0=>serializer_g0_0_9_0_0, M0=>'X', 
                CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, F1=>serializer_g2, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_0_15, Q0=>open);
    serializer_SLICE_63I: SLOGICB
      generic map (LUT0_INITVAL=>X"8800", LUT1_INITVAL=>X"0001")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_2, 
                B1=>serializer_R_debounce_cnt_20, 
                C1=>serializer_R_debounce_cnt_21, 
                D1=>serializer_R_debounce_cnt_3, DI1=>'X', DI0=>'X', 
                A0=>serializer_g0_1_5_0, B0=>serializer_g0_0_9, C0=>'X', 
                D0=>serializer_g0_1_4, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>serializer_g0_0_9, Q1=>open, OFX0=>open, 
                F0=>serializer_g0_11, Q0=>open);
    serializer_SLICE_64I: SLOGICB
      generic map (LUT0_INITVAL=>X"FFFD", LUT1_INITVAL=>X"FFFE")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_14, 
                B1=>serializer_R_debounce_cnt_12, 
                C1=>serializer_R_debounce_cnt_13, 
                D1=>serializer_R_debounce_cnt_15, DI1=>'X', DI0=>'X', 
                A0=>serializer_g0_0_9, B0=>serializer_g1_8, 
                C0=>serializer_g1_9, D0=>serializer_g1_10, M0=>'X', CE=>'X', 
                CLK=>'X', LSR=>'X', OFX1=>open, F1=>serializer_g1_10, Q1=>open, 
                OFX0=>open, F0=>serializer_g1_15, Q0=>open);
    serializer_SLICE_65I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0300")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', 
                B1=>serializer_R_debounce_cnt_1, 
                C1=>serializer_R_debounce_cnt_4, D1=>serializer_g1_9_0, 
                DI1=>'X', DI0=>'X', A0=>serializer_R_debounce_cnt_21, 
                B0=>serializer_R_debounce_cnt_6, 
                C0=>serializer_R_debounce_cnt_3, 
                D0=>serializer_R_debounce_cnt_2, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g1_7_1, Q1=>open, 
                OFX0=>open, F0=>serializer_g1_9_0, Q0=>open);
    serializer_SLICE_66I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0400")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_28, 
                B1=>serializer_un14_r_debounce_cnt_30_11, 
                C1=>serializer_R_debounce_cnt_22, 
                D1=>serializer_un14_r_debounce_cnt_26_5, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_25, 
                B0=>serializer_R_debounce_cnt_24, 
                C0=>serializer_R_debounce_cnt_23, 
                D0=>serializer_R_debounce_cnt_26, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g1_14_1, Q1=>open, 
                OFX0=>open, F0=>serializer_un14_r_debounce_cnt_30_11, Q0=>open);
    serializer_SLICE_67I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"8000")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_g1_7_1, 
                B1=>serializer_g2, C1=>serializer_g1_8_0, 
                D1=>serializer_g1_9_2, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_20, 
                B0=>serializer_R_debounce_cnt_7, 
                C0=>serializer_R_debounce_cnt_5, 
                D0=>serializer_R_debounce_cnt_31, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, 
                F1=>serializer_R_debounce_cnt_RNIQ40E6_23, Q1=>open, 
                OFX0=>open, F0=>serializer_g1_8_0, Q0=>open);
    serializer_SLICE_68I: SLOGICB
      generic map (LUT0_INITVAL=>X"0010", LUT1_INITVAL=>X"8CCC")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_un1_R_tx_phase_1, 
                B1=>serializer_g1_10_0, C1=>serializer_R_baudgen_16, 
                D1=>serializer_un6_r_tx_tickcnt, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_22, 
                B0=>serializer_R_debounce_cnt_25, 
                C0=>serializer_R_debounce_cnt_0, 
                D0=>serializer_R_debounce_cnt_26, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_0_sn, Q1=>open, 
                OFX0=>open, F0=>serializer_g1_10_0, Q0=>open);
    serializer_SLICE_69I: SLOGICB
      generic map (LUT0_INITVAL=>X"0010", LUT1_INITVAL=>X"0011")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_16, 
                B1=>serializer_R_debounce_cnt_17, C1=>'X', 
                D1=>serializer_R_debounce_cnt_18, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_19, 
                B0=>serializer_R_debounce_cnt_22, 
                C0=>serializer_R_debounce_cnt_RNI6IUF_16, 
                D0=>serializer_R_debounce_cnt_31, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_debounce_cnt_RNI6IUF_16, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_0_6, Q0=>open);
    serializer_SLICE_70I: SLOGICB
      generic map (LUT0_INITVAL=>X"0010", LUT1_INITVAL=>X"0101")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_10, 
                B1=>serializer_R_debounce_cnt_9, 
                C1=>serializer_R_debounce_cnt_8, D1=>'X', DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_4, 
                B0=>serializer_R_debounce_cnt_11, 
                C0=>serializer_R_debounce_cnt_RNI0D2O_10, 
                D0=>serializer_R_debounce_cnt_5, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_debounce_cnt_RNI0D2O_10, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_3_6, Q0=>open);
    serializer_SLICE_71I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0001")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_15, 
                B1=>serializer_R_debounce_cnt_12, 
                C1=>serializer_R_debounce_cnt_13, 
                D1=>serializer_R_debounce_cnt_14, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_15, 
                B0=>serializer_R_debounce_cnt_12, 
                C0=>serializer_R_debounce_cnt_13, 
                D0=>serializer_R_debounce_cnt_14, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, 
                F1=>serializer_R_debounce_cnt_RNIQ98L_0_12, Q1=>open, 
                OFX0=>open, F0=>serializer_R_debounce_cnt_RNIQ98L_12, Q0=>open);
    SLICE_72I: SLOGICB
      generic map (LUT0_INITVAL=>X"0011", LUT1_INITVAL=>X"0011")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>btn_up_c, B1=>btn_right_c, 
                C1=>'X', D1=>btn_left_c, DI1=>'X', DI0=>'X', A0=>btn_up_c, 
                B0=>btn_right_c, C0=>'X', D0=>btn_left_c, M0=>'X', CE=>'X', 
                CLK=>'X', LSR=>'X', OFX1=>open, F1=>serializer_a_1_i_a2_0_0_7, 
                Q1=>open, OFX0=>open, F0=>modul_brojke_N_17, Q0=>open);
    SLICE_73I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"D8D8")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>btn_right_c, B1=>btn_down_c, 
                C1=>btn_center_c, D1=>'X', DI1=>'X', DI0=>'X', A0=>btn_right_c, 
                B0=>btn_down_c, C0=>btn_center_c, D0=>btn_left_c, M0=>'X', 
                CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, F1=>serializer_a_6, 
                Q1=>open, OFX0=>open, F0=>modul_brojke_N_19, Q0=>open);
    serializer_SLICE_74I: SLOGICB
      generic map (LUT0_INITVAL=>X"6CCC", LUT1_INITVAL=>X"5AAA")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_tx_tickcnt_2, 
                B1=>'X', C1=>serializer_R_tx_tickcnt_1, 
                D1=>serializer_R_tx_tickcnt_0, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_tx_tickcnt_2, B0=>serializer_R_tx_tickcnt_3, 
                C0=>serializer_R_tx_tickcnt_1, D0=>serializer_R_tx_tickcnt_0, 
                M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>serializer_R_tx_tickcnt_n2, Q1=>open, OFX0=>open, 
                F0=>serializer_R_tx_tickcnt_n3, Q0=>open);
    serializer_SLICE_75I: SLOGICB
      generic map (LUT0_INITVAL=>X"0002", LUT1_INITVAL=>X"0100")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_28, 
                B1=>serializer_R_debounce_cnt_22, 
                C1=>serializer_R_debounce_cnt_27, 
                D1=>serializer_R_debounce_cnt_0, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_0, 
                B0=>serializer_R_debounce_cnt_6, 
                C0=>serializer_R_debounce_cnt_28, 
                D0=>serializer_R_debounce_cnt_22, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_1_5_0, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_1_11, Q0=>open);
    serializer_SLICE_76I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"FFFE")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_29, 
                B1=>serializer_R_debounce_cnt_30, 
                C1=>serializer_R_debounce_cnt_27, 
                D1=>serializer_R_debounce_cnt_1, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_29, 
                B0=>serializer_R_debounce_cnt_30, 
                C0=>serializer_R_debounce_cnt_31, 
                D0=>serializer_R_debounce_cnt_1, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g1_8, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_1_4, Q0=>open);
    serializer_SLICE_77I: SLOGICB
      generic map (LUT0_INITVAL=>X"4F40", LUT1_INITVAL=>X"4444")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_un1_R_tx_phase_1, 
                B1=>serializer_R_baudgen_16, C1=>'X', D1=>'X', DI1=>'X', 
                DI0=>'X', A0=>serializer_R_debounce_cnt_RNI1TKI2_12, 
                B0=>serializer_R_debounce_cnt_RNIQ40E6_23, 
                C0=>serializer_g0_0_sn, D0=>serializer_R_tx_ser_0_sqmuxa, 
                M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>serializer_r_tx_tickcnt12, Q1=>open, OFX0=>open, 
                F0=>serializer_R_tx_ser_1_sqmuxa_i, Q0=>open);
    serializer_SLICE_78I: SLOGICB
      generic map (LUT0_INITVAL=>X"FFFE", LUT1_INITVAL=>X"4000")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_tx_phase_RNO_2_1, 
                B1=>serializer_g2, C1=>serializer_g0_0_4_0, 
                D1=>serializer_R_tx_phase_RNO_3_1, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_byte_old_1, B0=>serializer_R_byte_old_0, 
                C0=>serializer_R_byte_old_5, D0=>serializer_R_byte_old_3, 
                M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>serializer_un14_r_debounce_cnt_0_0, Q1=>open, OFX0=>open, 
                F0=>serializer_g0_2_4, Q0=>open);
    serializer_SLICE_79I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0303")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', 
                B1=>serializer_R_debounce_cnt_20, 
                C1=>serializer_R_debounce_cnt_21, D1=>'X', DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_24, 
                B0=>serializer_R_debounce_cnt_25, 
                C0=>serializer_R_debounce_cnt_26, 
                D0=>serializer_R_debounce_cnt_23, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_0_0, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_0_5, Q0=>open);
    serializer_SLICE_80I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0001")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_23, 
                B1=>serializer_R_debounce_cnt_24, 
                C1=>serializer_R_debounce_cnt_16, 
                D1=>serializer_R_debounce_cnt_17, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_16, 
                B0=>serializer_R_debounce_cnt_18, 
                C0=>serializer_R_debounce_cnt_19, 
                D0=>serializer_R_debounce_cnt_17, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_13_N_6L10_1, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_1_8, Q0=>open);
    serializer_SLICE_81I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0001")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_18, 
                B1=>serializer_R_debounce_cnt_21, 
                C1=>serializer_R_debounce_cnt_20, 
                D1=>serializer_R_debounce_cnt_19, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_2, 
                B0=>serializer_R_debounce_cnt_21, 
                C0=>serializer_R_debounce_cnt_20, 
                D0=>serializer_R_debounce_cnt_3, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_tx_phase_RNO_4_1, 
                Q1=>open, OFX0=>open, F0=>serializer_g0_1_10, Q0=>open);
    serializer_SLICE_82I: SLOGICB
      generic map (LUT0_INITVAL=>X"0001", LUT1_INITVAL=>X"0033")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', 
                B1=>serializer_R_debounce_cnt_30, C1=>'X', 
                D1=>serializer_R_debounce_cnt_28, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_29, 
                B0=>serializer_R_debounce_cnt_24, 
                C0=>serializer_R_debounce_cnt_23, 
                D0=>serializer_R_debounce_cnt_27, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_debounce_cnt_RNI1CNA_30, 
                Q1=>open, OFX0=>open, F0=>serializer_g1_9_2, Q0=>open);
    serializer_SLICE_83I: SLOGICB
      generic map (LUT0_INITVAL=>X"FFFE", LUT1_INITVAL=>X"0100")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_debounce_cnt_6, 
                B1=>serializer_R_debounce_cnt_2, 
                C1=>serializer_R_debounce_cnt_3, 
                D1=>serializer_R_debounce_cnt_0, DI1=>'X', DI0=>'X', 
                A0=>serializer_R_debounce_cnt_7, 
                B0=>serializer_R_debounce_cnt_5, 
                C0=>serializer_R_debounce_cnt_4, 
                D0=>serializer_R_debounce_cnt_31, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_R_tx_phase_RNO_5_1, 
                Q1=>open, OFX0=>open, F0=>serializer_g1_9, Q0=>open);
    serializer_SLICE_84I: SLOGICB
      generic map (LUT0_INITVAL=>X"8000", LUT1_INITVAL=>X"0101")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>serializer_R_tx_phase_2, 
                B1=>serializer_R_tx_phase_1, C1=>serializer_R_tx_phase_3, 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>serializer_R_tx_phase_2, 
                B0=>serializer_R_tx_phase_1, C0=>serializer_R_baudgen_16, 
                D0=>serializer_R_tx_phase_0, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>serializer_g0_10_1, Q1=>open, 
                OFX0=>open, F0=>serializer_g0_3_2, Q0=>open);
    serializer_SLICE_85I: SLOGICB
      generic map (LUT0_INITVAL=>X"0003")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>btn_center_c, 
                C0=>btn_right_c, D0=>btn_up_c, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>open, Q1=>open, OFX0=>open, 
                F0=>serializer_N_7, Q0=>open);
    serializer_SLICE_86I: SLOGICB
      generic map (LUT0_INITVAL=>X"33CC")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', 
                B0=>serializer_R_tx_tickcnt_1, C0=>'X', 
                D0=>serializer_R_tx_tickcnt_0, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>open, Q1=>open, OFX0=>open, 
                F0=>serializer_R_tx_tickcnt_n1, Q0=>open);
    serializer_SLICE_87I: SLOGICB
      generic map (LUT0_INITVAL=>X"CC00")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>btn_down_c, C0=>'X', 
                D0=>btn_right_c, M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', 
                OFX1=>open, F1=>open, Q1=>open, OFX0=>open, 
                F0=>serializer_N_24, Q0=>open);
    serializer_SLICE_88I: SLOGICB
      generic map (LUT0_INITVAL=>X"DDDD")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>serializer_R_debounce_cnt_0, 
                B0=>serializer_R_debounce_cnt_6, C0=>'X', D0=>'X', M0=>'X', 
                CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, F1=>open, Q1=>open, 
                OFX0=>open, F0=>serializer_g1_7_0, Q0=>open);
    serializer_SLICE_89I: SLOGICB
      generic map (LUT0_INITVAL=>X"7FFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', 
                A0=>serializer_R_tx_tickcnt_fast_2, 
                B0=>serializer_R_tx_tickcnt_fast_1, 
                C0=>serializer_R_tx_tickcnt_3, 
                D0=>serializer_R_tx_tickcnt_fast_0, M0=>'X', CE=>'X', CLK=>'X', 
                LSR=>'X', OFX1=>open, F1=>open, Q1=>open, OFX0=>open, 
                F0=>serializer_g0_10_sx, Q0=>open);
    serializer_SLICE_90I: SLOGICB
      generic map (LUT0_INITVAL=>X"FFFF")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', C0=>'X', 
                D0=>'X', M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>serializer_VCC, Q0=>open);
    SLICE_91I: SLOGICB
      generic map (LUT0_INITVAL=>X"0000")
      port map (M1=>'X', FXA=>'X', FXB=>'X', A1=>'X', B1=>'X', C1=>'X', 
                D1=>'X', DI1=>'X', DI0=>'X', A0=>'X', B0=>'X', C0=>'X', 
                D0=>'X', M0=>'X', CE=>'X', CLK=>'X', LSR=>'X', OFX1=>open, 
                F1=>open, Q1=>open, OFX0=>open, F0=>GND, Q0=>open);
    rs232_txI: rs232_txB
      port map (IOLDO=>rs232_tx_c, rs232tx=>rs232_tx);
    rs232_tx_MGIOLI: rs232_tx_MGIOL
      port map (IOLDO=>rs232_tx_c, ONEG0=>serializer_R_tx_ser_5_0, 
                CE=>serializer_R_tx_ser_1_sqmuxa_i, CLK=>clk_25m_c);
    btn_leftI: btn_leftB
      port map (PADDI=>btn_left_c, btnleft=>btn_left);
    sw_0_I: sw_0_B
      port map (PADDI=>sw_c_0, sw0=>sw(0));
    led_7_I: led_7_B
      port map (PADDO=>GND, led7=>led(7));
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
    led_0_I: led_0_B
      port map (PADDO=>led_c_0, led0=>led(0));
    clk_25mI: clk_25mB
      port map (PADDI=>clk_25m_c, clk25m=>clk_25m);
    btn_centerI: btn_centerB
      port map (PADDI=>btn_center_c, btncenter=>btn_center);
    btn_downI: btn_downB
      port map (PADDI=>btn_down_c, btndown=>btn_down);
    btn_upI: btn_upB
      port map (PADDI=>btn_up_c, btnup=>btn_up);
    btn_rightI: btn_rightB
      port map (PADDI=>btn_right_c, btnright=>btn_right);
    VHI_INST: VHI
      port map (Z=>VCCI);
    PUR_INST: PUR
      port map (PUR=>VCCI);
    GSR_INST: GSR
      port map (GSR=>VCCI);
  end Structure;



  library IEEE, vital2000, XP2;
  configuration Structure_CON of slova is
    for Structure
    end for;
  end Structure_CON;


