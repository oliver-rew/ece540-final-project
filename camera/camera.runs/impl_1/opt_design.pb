
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px� 
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
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px� 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px� 
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
a
DRC finished with %s
272*project2(
0 Errors, 7 Warnings2default:defaultZ1-461h px� 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 2218.352 ; gain = 64.031 ; free physical = 3868 ; free virtual = 88682default:defaulth px� 
g

Starting %s Task
103*constraints2,
Cache Timing Information2default:defaultZ18-103h px� 
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
8
Deriving generated clocks
2*timingZ38-2h px� 
P
;Ending Cache Timing Information Task | Checksum: 1b90202d4
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.10 ; elapsed = 00:00:00.05 . Memory (MB): peak = 2218.352 ; gain = 0.000 ; free physical = 3868 ; free virtual = 88682default:defaulth px� 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px� 
i

Phase %s%s
101*constraints2
1 2default:default2
Retarget2default:defaultZ18-101h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px� 
<
'Phase 1 Retarget | Checksum: 1f556da2e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.14 ; elapsed = 00:00:00.06 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
122default:default2
122default:defaultZ31-389h px� 
�
�In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2
Retarget2default:default2
12default:defaultZ31-1021h px� 
u

Phase %s%s
101*constraints2
2 2default:default2(
Constant propagation2default:defaultZ18-101h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
H
3Phase 2 Constant propagation | Checksum: 1f556da2e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.14 ; elapsed = 00:00:00.06 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
02default:default2
02default:defaultZ31-389h px� 
f

Phase %s%s
101*constraints2
3 2default:default2
Sweep2default:defaultZ18-101h px� 
9
$Phase 3 Sweep | Checksum: 28e1f3729
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.16 ; elapsed = 00:00:00.09 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
02default:default2
12default:defaultZ31-389h px� 
r

Phase %s%s
101*constraints2
4 2default:default2%
BUFG optimization2default:defaultZ18-101h px� 
�
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2F
2instance_name/inst/clk_31_5MHz_clk_wiz_1_BUFG_inst2default:default2
02default:default2A
-instance_name/inst/clk_31_5MHz_clk_wiz_1_BUFG2default:defaultZ31-194h px� 
W
!Inserted %s BUFG(s) on clock nets140*opt2
12default:defaultZ31-193h px� 
E
0Phase 4 BUFG optimization | Checksum: 1b1d17a6f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.18 ; elapsed = 00:00:00.10 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
�
EPhase %s created %s cells of which %s are BUFGs and removed %s cells.395*opt2%
BUFG optimization2default:default2
02default:default2
02default:default2
02default:defaultZ31-662h px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px� 
O
:Phase 5 Shift Register Optimization | Checksum: 1f1fa418d
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.23 ; elapsed = 00:00:00.16 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px� 
x

Phase %s%s
101*constraints2
6 2default:default2+
Post Processing Netlist2default:defaultZ18-101h px� 
K
6Phase 6 Post Processing Netlist | Checksum: 1d3f7d1d3
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.24 ; elapsed = 00:00:00.17 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
�
.Phase %s created %s cells and removed %s cells267*opt2+
Post Processing Netlist2default:default2
02default:default2
02default:defaultZ31-389h px� 
/
Opt_design Change Summary
*commonh px� 
/
=========================
*commonh px� 


*commonh px� 


*commonh px� 
�
z-------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Phase                        |  #Cells created  |  #Cells Removed  |  #Constrained objects preventing optimizations  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Retarget                     |              12  |              12  |                                              1  |
|  Constant propagation         |               0  |               0  |                                              0  |
|  Sweep                        |               0  |               1  |                                              0  |
|  BUFG optimization            |               0  |               0  |                                              0  |
|  Shift Register Optimization  |               0  |               0  |                                              0  |
|  Post Processing Netlist      |               0  |               0  |                                              0  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.01 ; elapsed = 00:00:00 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
J
5Ending Logic Optimization Task | Checksum: 1cf17cc46
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.25 ; elapsed = 00:00:00.17 . Memory (MB): peak = 2267.336 ; gain = 0.000 ; free physical = 3805 ; free virtual = 88052default:defaulth px� 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px� 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px� 
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
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2default:default2
 2default:default2
27.2782default:default2
0.0002default:defaultZ32-619h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
=
Applying IDT optimizations ...
9*pwroptZ34-9h px� 
?
Applying ODC optimizations ...
10*pwroptZ34-10h px� 


*pwropth px� 
e

Starting %s Task
103*constraints2*
PowerOpt Patch Enables2default:defaultZ18-103h px� 
�
�WRITE_MODE attribute of %s BRAM(s) out of a total of %s has been updated to save power.
    Run report_power_opt to get a complete listing of the BRAMs updated.
129*pwropt2
02default:default2
392default:defaultZ34-162h px� 
d
+Structural ODC has moved %s WE to EN ports
155*pwropt2
02default:defaultZ34-201h px� 
�
CNumber of BRAM Ports augmented: %s newly gated: %s Total Ports: %s
65*pwropt2
942default:default2
392default:default2
782default:defaultZ34-65h px� 
h
1Number of Flops added for Enable Generation: %s

23*pwropt2
42default:defaultZ34-23h px� 
N
9Ending PowerOpt Patch Enables Task | Checksum: 1f62e4dbd
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.21 ; elapsed = 00:00:00.19 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3767 ; free virtual = 87672default:defaulth px� 
J
5Ending Power Optimization Task | Checksum: 1f62e4dbd
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 2636.949 ; gain = 369.613 ; free physical = 3774 ; free virtual = 87742default:defaulth px� 
\

Starting %s Task
103*constraints2!
Final Cleanup2default:defaultZ18-103h px� 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px� 
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
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2F
2instance_name/inst/clk_31_5MHz_clk_wiz_1_BUFG_inst2default:default2
02default:default2A
-instance_name/inst/clk_31_5MHz_clk_wiz_1_BUFG2default:defaultZ31-194h px� 
W
!Inserted %s BUFG(s) on clock nets140*opt2
12default:defaultZ31-193h px� 
J
5Ending Logic Optimization Task | Checksum: 1c1a4b84a
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.23 ; elapsed = 00:00:00.12 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3779 ; free virtual = 87792default:defaulth px� 
E
0Ending Final Cleanup Task | Checksum: 1c1a4b84a
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.97 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3779 ; free virtual = 87792default:defaulth px� 
b

Starting %s Task
103*constraints2'
Netlist Obfuscation2default:defaultZ18-103h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37792default:default2
87792default:defaultZ17-722h px� 
K
6Ending Netlist Obfuscation Task | Checksum: 1c1a4b84a
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 2636.949 ; gain = 0.000 ; free physical = 3779 ; free virtual = 87792default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
482default:default2
142default:default2
32default:default2
02default:defaultZ4-41h px� 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
opt_design: 2default:default2
00:00:072default:default2
00:00:072default:default2
2636.9492default:default2
482.6292default:default2
37792default:default2
87792default:defaultZ17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37792default:default2
87792default:defaultZ17-722h px� 
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
00:00:00.062default:default2
00:00:00.012default:default2
2636.9492default:default2
0.0002default:default2
37772default:default2
87782default:defaultZ17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2636.9492default:default2
0.0002default:default2
37772default:default2
87782default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2f
R/home/rew/Documents/final_project/camera/camera.runs/impl_1/mfp_nexys4_ddr_opt.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2�
|Executing : report_drc -file mfp_nexys4_ddr_drc_opted.rpt -pb mfp_nexys4_ddr_drc_opted.pb -rpx mfp_nexys4_ddr_drc_opted.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
oreport_drc -file mfp_nexys4_ddr_drc_opted.rpt -pb mfp_nexys4_ddr_drc_opted.pb -rpx mfp_nexys4_ddr_drc_opted.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
X/home/rew/Documents/final_project/camera/camera.runs/impl_1/mfp_nexys4_ddr_drc_opted.rptX/home/rew/Documents/final_project/camera/camera.runs/impl_1/mfp_nexys4_ddr_drc_opted.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 


End Record