//Maya ASCII 2017ff05 scene
//Name: testGpuCache.ma
//Last modified: Mon, May 21, 2018 11:57:21 AM
//Codeset: 1251
requires maya "2017ff05";
requires -nodeType "gpuCache" "gpuCache" "1.0";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t pal;
fileInfo "application" "maya";
fileInfo "product" "Maya 2017";
fileInfo "version" "2017";
fileInfo "cutIdentifier" "201710312130-1018716";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
fileInfo "vrayBuild" "3.60.04 39f5708";
createNode transform -s -n "persp";
	rename -uid "D4C16541-45E4-3A06-5C32-9EA868A323AC";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 5.1081606089902287 4.1688818013971236 5.2646991562592458 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-014 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "5A1B30E7-4D4A-5323-FF5E-40866691D4E7";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 8.4330839857073006;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "88E6B694-4BD9-C782-DBF1-3889ED8D3B51";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "7EE0AE5E-44B2-C6DD-1725-ABAA4A048BA7";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	rename -uid "3ADC53B9-4DBB-E37A-90EA-90BF980E3A09";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "85830353-4049-8D73-D3C2-7B89639C9E2E";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	rename -uid "36470615-4B23-68FA-933F-BBAFDFA2CFE4";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "D086AC8F-4689-B5D1-7697-97BF0EB32816";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "Main";
	rename -uid "922B2735-4C40-D328-4592-77B118E2E82B";
createNode nurbsCurve -n "MainShape" -p "Main";
	rename -uid "FEE1AB4A-46BA-A17C-243B-CDA5DCA8136C";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 8 2 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.0461531315482799 2.3229265878572178e-016 -1.0461531315482784
		-1.6879142809954929e-016 3.2851142849447368e-016 -1.479483946954661
		-1.046153131548279 2.3229265878572193e-016 -1.046153131548279
		-1.479483946954661 9.5194393270671503e-032 -4.2871743406155663e-016
		-1.0461531315482793 -2.3229265878572183e-016 1.0461531315482786
		-4.4579738700123938e-016 -3.2851142849447373e-016 1.4794839469546612
		1.0461531315482784 -2.3229265878572193e-016 1.046153131548279
		1.479483946954661 -1.7644412908294787e-031 7.9463371398967574e-016
		1.0461531315482799 2.3229265878572178e-016 -1.0461531315482784
		-1.6879142809954929e-016 3.2851142849447368e-016 -1.479483946954661
		-1.046153131548279 2.3229265878572193e-016 -1.046153131548279
		;
createNode transform -n "testGpuCache" -p "Main";
	rename -uid "E36CF5D0-4EBB-61D4-9BFF-55A22F5EC0C7";
	setAttr ".ovdt" 1;
	setAttr ".ove" yes;
createNode gpuCache -n "testGpuCacheShape" -p "testGpuCache";
	rename -uid "072F4231-46B7-BD6A-C219-F9BD55A66472";
	setAttr -k off ".v";
	setAttr ".ovdt" 1;
	setAttr ".ove" yes;
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".cfn" -type "string" "testGpuCache.abc";
	setAttr ".cmp" -type "string" "|";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "F85CA4CD-4642-A3C0-1EDA-729DDCD80A8D";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "76872A39-4AFE-6C02-0BA2-809DC36575F3";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "21E42791-4C80-AA8A-2D5B-E9B8B92A861C";
createNode displayLayerManager -n "layerManager";
	rename -uid "3EDFC50B-40EC-61E3-A99C-5CAF03988259";
createNode displayLayer -n "defaultLayer";
	rename -uid "45B840E7-4956-700D-F28C-52A008B0A540";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "6F6BF749-4435-E677-9475-50A02FA845E3";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "F98D5F32-4FF4-120E-C3BF-EDA8869E327C";
	setAttr ".g" yes;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "5D2D6414-4EC5-BE46-2A3C-A88A5CBE0651";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 120 -ast 1 -aet 200 ";
	setAttr ".st" 6;
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".fprt" yes;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr ".fs" 1;
	setAttr ".ef" 10;
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :ikSystem;
	setAttr -s 4 ".sol";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of testGpuCache.ma
