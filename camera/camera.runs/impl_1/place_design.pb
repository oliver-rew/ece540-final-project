
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC28
 ""
JD[1]JD[1]2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC28
 ""
JD[3]JD[3]2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC28
 ""
JD[4]JD[4]2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC28
 ""
JD[5]JD[5]2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC28
 ""
JD[6]JD[6]2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC28
 ""
JD[7]JD[7]2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px� 
�
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC28
 ""
JD[8]JD[8]2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px� 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 7 Warnings2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
82default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37692default:default2
87692default:defaultZ17-722h px� 
[
FPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 146e1204c
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.01 ; elapsed = 00:00:00.02 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3769 ; free virtual = 87692default:defaulth px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37692default:default2
87692default:defaultZ17-722h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
�
[Partially locked IO Bus is found. Following components of the IO Bus %s are not locked: %s
87*place2
JB2default:default2�
\ '<MSGMETA::BEGIN::BLOCK>JB[6]<MSGMETA::END>'  '<MSGMETA::BEGIN::BLOCK>JB[5]<MSGMETA::END>' "
JB[6]2 ':'  '"
JB[5]:' 2default:default8Z30-87h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place2$
cam_vga/bram_i_12default:default2
392default:default2�
�	cam_vga/bram/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[9].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.CASCADED_PRIM36.ram_B {RAMB36E1}
	cam_vga/bram/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[9].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.CASCADED_PRIM36.ram_T {RAMB36E1}
	cam_vga/bram/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[8].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.CASCADED_PRIM36.ram_B {RAMB36E1}
	cam_vga/bram/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[8].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.CASCADED_PRIM36.ram_T {RAMB36E1}
	cam_vga/bram/U0/inst_blk_mem_gen/gnbram.gnativebmg.native_blk_mem_gen/valid.cstr/ramloop[7].ram.r/prim_noinit.ram/DEVICE_7SERIES.NO_BMM_INFO.SDP.CASCADED_PRIM36.ram_T {RAMB36E1}
2default:defaultZ30-568h px� 
�
�%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2
clk_virt2default:default2{
e/home/rew/Documents/final_project/camera/camera.srcs/constrs_1/imports/constraints/mfp_nexys4_ddr.xdc2default:default2
2802default:default8@Z18-483h px� 
�
�%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2
tck2default:default2{
e/home/rew/Documents/final_project/camera/camera.srcs/constrs_1/imports/constraints/mfp_nexys4_ddr.xdc2default:default2
2842default:default8@Z18-483h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�
9Poor placement for routing between an IO pin and BUFG. %s528*place2�
�This is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	<MSGMETA::BEGIN::BLOCK>ibufg1<MSGMETA::END> (IBUF.O) is locked to IOB_X1Y123
	<MSGMETA::BEGIN::BLOCK>bug1<MSGMETA::END> (BUFG.I) is provisionally placed by clockplacer on BUFGCTRL_X0Y0
"�
ibufg12�This is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	:# (IBUF.O) is locked to IOB_X1Y123
	"L
bug1:B (BUFG.I) is provisionally placed by clockplacer on BUFGCTRL_X0Y0
2default:default8Z30-574h px� 
h
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 19db15580
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.84 ; elapsed = 00:00:00.52 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3767 ; free virtual = 87672default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 1e7090bdc
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.77 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3769 ; free virtual = 87692default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 1e7090bdc
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.77 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3769 ; free virtual = 87692default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 1e7090bdc
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.78 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3769 ; free virtual = 87692default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px� 
C
.Phase 2.1 Floorplanning | Checksum: 1a9547fe9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.86 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3766 ; free virtual = 87672default:defaulth px� 


Phase %s%s
101*constraints2
2.2 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px� 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px� 
�
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
0No setup violation found.  %s was not performed.344*physynth2-
DSP Register Optimization2default:defaultZ32-670h px� 
�
0No setup violation found.  %s was not performed.344*physynth2/
Shift Register Optimization2default:defaultZ32-670h px� 
�
0No setup violation found.  %s was not performed.344*physynth2.
BRAM Register Optimization2default:defaultZ32-670h px� 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37382default:default2
87382default:defaultZ17-722h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
�----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization                  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Very High Fanout              |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register                  |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  Shift Register                |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  BRAM Register                 |            0  |              0  |                     0  |           0  |           0  |  00:00:00  |
|  HD Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                         |            0  |              0  |                     0  |           0  |           2  |  00:00:00  |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
R
=Phase 2.2 Physical Synthesis In Placer | Checksum: 2c7fcae08
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:06 ; elapsed = 00:00:02 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3738 ; free virtual = 87382default:defaulth px� 
D
/Phase 2 Global Placement | Checksum: 1ea14ffbf
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:06 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3744 ; free virtual = 87442default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 1ea14ffbf
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:06 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3744 ; free virtual = 87442default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1a3eb4a54
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:06 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3743 ; free virtual = 87442default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
K
6Phase 3.3 Area Swap Optimization | Checksum: fc4394f4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3743 ; free virtual = 87442default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 110587b1f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3743 ; free virtual = 87442default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.5 Small Shape Detail Placement | Checksum: 27110a1cc
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3741 ; free virtual = 87422default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.6 Re-assign LUT pins | Checksum: 1aee3615b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3741 ; free virtual = 87422default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.7 Pipeline Register Optimization | Checksum: 19b12c730
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3741 ; free virtual = 87422default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 19b12c730
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3741 ; free virtual = 87422default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
�
�%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2
clk_virt2default:default2{
e/home/rew/Documents/final_project/camera/camera.srcs/constrs_1/imports/constraints/mfp_nexys4_ddr.xdc2default:default2
2802default:default8@Z18-483h px� 
�
�%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2
tck2default:default2{
e/home/rew/Documents/final_project/camera/camera.srcs/constrs_1/imports/constraints/mfp_nexys4_ddr.xdc2default:default2
2842default:default8@Z18-483h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 1018b9fe1
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s bufg driver replicated, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason40*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-46h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 1018b9fe1
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3741 ; free virtual = 87422default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
26.5932default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 118cc8747
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3741 ; free virtual = 87422default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 118cc8747
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:07 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3741 ; free virtual = 87412default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 118cc8747
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:08 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3742 ; free virtual = 87422default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 118cc8747
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:08 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3742 ; free virtual = 87422default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37422default:default2
87422default:defaultZ17-722h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 1a1b1e398
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:08 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3742 ; free virtual = 87422default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 1a1b1e398
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:08 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3742 ; free virtual = 87422default:defaulth px� 
=
(Ending Placer Task | Checksum: b89d088b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:08 ; elapsed = 00:00:03 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3758 ; free virtual = 87592default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
792default:default2
242default:default2
32default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37582default:default2
87592default:defaultZ17-722h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:00.232default:default2
00:00:00.062default:default2
2636.9492default:default2
0.0002default:default2
37572default:default2
87592default:defaultZ17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37572default:default2
87592default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2i
U/home/rew/Documents/final_project/camera/camera.runs/impl_1/mfp_nexys4_ddr_placed.dcp2default:defaultZ17-1381h px� 
i
%s4*runtcl2M
9Executing : report_io -file mfp_nexys4_ddr_io_placed.rpt
2default:defaulth px� 
�
�report_io: Time (s): cpu = 00:00:00.12 ; elapsed = 00:00:00.17 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3753 ; free virtual = 8755
*commonh px� 
�
%s4*runtcl2�
tExecuting : report_utilization -file mfp_nexys4_ddr_utilization_placed.rpt -pb mfp_nexys4_ddr_utilization_placed.pb
2default:defaulth px� 
�
%s4*runtcl2j
VExecuting : report_control_sets -verbose -file mfp_nexys4_ddr_control_sets_placed.rpt
2default:defaulth px� 
�
�report_control_sets: Time (s): cpu = 00:00:00.05 ; elapsed = 00:00:00.09 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3761 ; free virtual = 8762
*commonh px� 


End Record