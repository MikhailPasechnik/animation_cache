//Maya ASCII 2017ff05 scene
//Name: testRig.ma
//Last modified: Mon, May 21, 2018 11:43:25 AM
//Codeset: 1251
file -rdi 1 -ns "geo" -rfn "geoRN" -op "v=0;" -typ "mayaAscii" "testGeometry.ma";
file -r -ns "geo" -dr 1 -rfn "geoRN" -op "v=0;" -typ "mayaAscii" "testGeometry.ma";
requires maya "2017ff05";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t pal;
fileInfo "application" "maya";
fileInfo "product" "Maya 2017";
fileInfo "version" "2017";
fileInfo "cutIdentifier" "201710312130-1018716";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
fileInfo "vrayBuild" "3.60.04 39f5708";
createNode transform -s -n "persp";
	rename -uid "E5B2CEB3-4E60-1B0A-1FE5-EF89C9B4B4F0";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 7.8976693862754601 6.6970412062666602 12.60157392943413 ;
	setAttr ".r" -type "double3" -21.338352729603329 29.800000000000832 9.1630597562845652e-016 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "BF4AFB18-4497-DE92-3634-22A96B76FDF1";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 17.013411637606275;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "69F7EE9A-4B0D-ED8A-69A5-88A862893C45";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "F066916F-4DC4-297B-75DD-60B5A35F33FA";
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
	rename -uid "85510F9F-4F4B-6190-C78C-25A4AABDF124";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "20E647CD-4BD3-2E2D-2015-13A9F4F1ED3A";
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
	rename -uid "332BFF17-43C9-EB8B-26A8-F988B7ED7005";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "82493A80-4CE4-B59F-131C-DF8EB688D700";
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
	rename -uid "744BD0C1-4F5C-3162-0C8E-B18A8DD1972B";
createNode nurbsCurve -n "MainShape" -p "Main";
	rename -uid "E4F037C4-4BAC-178A-0CE9-FCAA13C13C01";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 8 2 no 3
		13 -2 -1 0 1 2 3 4 5 6 7 8 9 10
		11
		1.349596590920267 2.9967064183905933e-016 1.349596590920265
		-2.1775046985958584e-016 4.2379828593384823e-016 1.9086178026119338
		-1.3495965909202656 2.9967064183905948e-016 1.3495965909202656
		-1.9086178026119338 1.228061406676508e-031 5.5306968934964087e-016
		-1.3495965909202661 -2.9967064183905943e-016 -1.3495965909202654
		-5.7510379273788912e-016 -4.2379828593384833e-016 -1.9086178026119343
		1.349596590920265 -2.9967064183905953e-016 -1.3495965909202658
		1.9086178026119338 -2.2762288609299293e-031 -1.0251223449893998e-015
		1.349596590920267 2.9967064183905933e-016 1.349596590920265
		-2.1775046985958584e-016 4.2379828593384823e-016 1.9086178026119338
		-1.3495965909202656 2.9967064183905948e-016 1.3495965909202656
		;
createNode transform -n "geo1" -p "Main";
	rename -uid "786C7EC8-49A8-65B6-8E67-B99F89EF9574";
	setAttr ".rp" -type "double3" -1.1920928955078125e-007 0.44932589125230726 -1.7881393432617188e-007 ;
	setAttr ".sp" -type "double3" -1.1920928955078125e-007 0.44932589125230726 -1.7881393432617188e-007 ;
createNode transform -n "ffd1Lattice" -p "Main";
	rename -uid "047D76EB-48CD-E677-630C-429A515AFA4F";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -1.1920928955078125e-007 0.44932589125230726 -1.7881393432617188e-007 ;
	setAttr ".s" -type "double3" 2.0000002384185791 2.8986517825046145 2.0000005960464478 ;
createNode lattice -n "ffd1LatticeShape" -p "ffd1Lattice";
	rename -uid "CFAD4EF3-483E-9FF9-9314-399A60552065";
	setAttr -k off ".v";
	setAttr -s 4 ".iog[0].og";
	setAttr ".tw" yes;
createNode lattice -n "ffd1LatticeShapeOrig" -p "ffd1Lattice";
	rename -uid "2116C207-466F-2D64-308C-F982E6FE4903";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".cc" -type "lattice" 2 5 2 20 -0.5 -0.5 -0.5 0.5 -0.5
		 -0.5 -0.5 -0.25 -0.5 0.5 -0.25 -0.5 -0.5 0 -0.5 0.5 0 -0.5 -0.5 0.25 -0.5 0.5 0.25
		 -0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 -0.25 0.5 0.5 -0.25
		 0.5 -0.5 0 0.5 0.5 0 0.5 -0.5 0.25 0.5 0.5 0.25 0.5 -0.5 0.5 0.5 0.5 0.5 0.5 ;
createNode transform -n "ffd1Base" -p "Main";
	rename -uid "EAE01A80-425D-05E7-D27A-D8B431A0935B";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -1.1920928955078125e-007 0.44932589125230726 -1.7881393432617188e-007 ;
	setAttr ".s" -type "double3" 2.0000002384185791 2.8986517825046145 2.0000005960464478 ;
createNode baseLattice -n "ffd1BaseShape" -p "ffd1Base";
	rename -uid "343EFCDB-4BA5-5C03-2D2B-3AB8C4B1D646";
	setAttr ".ihi" 0;
	setAttr -k off ".v";
createNode transform -n "cluster1Handle" -p "Main";
	rename -uid "056BE0D8-4C89-4DAF-D2C1-ECAA1FE34264";
	setAttr ".rp" -type "double3" -1.1920928955078125e-007 1.5363203096915377 -1.7881393432617188e-007 ;
	setAttr ".sp" -type "double3" -1.1920928955078125e-007 1.5363203096915377 -1.7881393432617188e-007 ;
createNode clusterHandle -n "cluster1HandleShape" -p "cluster1Handle";
	rename -uid "766C2CDF-4836-6081-5B2E-06ABB212EAC6";
	setAttr ".ihi" 0;
	setAttr -k off ".v";
	setAttr ".or" -type "double3" -1.1920928955078125e-007 1.5363203096915377 -1.7881393432617188e-007 ;
createNode parentConstraint -n "cluster1Handle_parentConstraint1" -p "cluster1Handle";
	rename -uid "ADC63DDB-49E5-6C47-97F7-0788B5010AC7";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "SecondW0" -dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".rst" -type "double3" 1.1920928955078125e-007 1.5057537473807932 1.7881393432617188e-007 ;
	setAttr -k on ".w0";
createNode scaleConstraint -n "cluster1Handle_scaleConstraint1" -p "cluster1Handle";
	rename -uid "3819EBB2-4743-5971-0F92-7BA7A36310AE";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "SecondW0" -dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr -k on ".w0";
createNode transform -n "Second" -p "Main";
	rename -uid "09ED2F6A-4FBA-A657-3419-F593237F6261";
	setAttr ".rp" -type "double3" 0 2.0350758905225961 0 ;
	setAttr ".sp" -type "double3" 0 2.0350758905225961 0 ;
createNode nurbsCurve -n "SecondShape" -p "Second";
	rename -uid "96DEAC39-4B9D-3FD8-54A2-5499857EEB49";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode fosterParent -n "geoRNfosterParent1";
	rename -uid "B8444139-4CC1-0B15-F12A-E8A8AE15E113";
createNode mesh -n "cubeShapeDeformed" -p "geoRNfosterParent1";
	rename -uid "7AC5F602-4037-0883-E59B-FFB9DBB57440";
	setAttr -k off ".v";
	setAttr -s 4 ".iog[0].og";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode mesh -n "sphereShapeDeformed" -p "geoRNfosterParent1";
	rename -uid "D84400B1-422A-6CC2-691C-F79DCD97C3A4";
	setAttr -k off ".v";
	setAttr -s 4 ".iog[0].og";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
createNode lightLinker -s -n "lightLinker1";
	rename -uid "EE5C07B4-4020-1076-BF3A-CC8CE10B9A82";
	setAttr -s 4 ".lnk";
	setAttr -s 4 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "4A655103-4E88-DBCC-AA66-D89F42A43A2D";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "D20DA470-49D1-F6EA-16CE-FEA65444FB9E";
createNode displayLayerManager -n "layerManager";
	rename -uid "59760DE1-47D9-7BBE-D3DF-DAB65ABC91C9";
createNode displayLayer -n "defaultLayer";
	rename -uid "B7380334-4735-DEAC-A5A0-83BAB77EF1E4";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "28BFC2CC-4DF6-968F-7BC2-F38ED15E0F53";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "9E83961A-4857-1DE2-5D3B-958EBB5C25DC";
	setAttr ".g" yes;
createNode reference -n "geoRN";
	rename -uid "32407DEB-44CF-4867-ACC7-EAA089677C51";
	setAttr -s 4 ".phl";
	setAttr ".phl[1]" 0;
	setAttr ".phl[2]" 0;
	setAttr ".phl[3]" 0;
	setAttr ".phl[4]" 0;
	setAttr ".ed" -type "dataReferenceEdits" 
		"geoRN"
		"geoRN" 0
		"geoRN" 12
		0 "|geoRNfosterParent1|sphereShapeDeformed" "|Main|geo1|geo:sphere" "-s -r "
		
		0 "|geoRNfosterParent1|cubeShapeDeformed" "|Main|geo1|geo:cube" "-s -r "
		2 "|Main|geo1|geo:sphere" "overrideDisplayType" " 2"
		2 "|Main|geo1|geo:sphere" "overrideEnabled" " 1"
		2 "|Main|geo1|geo:sphere|geo:sphereShape" "intermediateObject" " 1"
		2 "|Main|geo1|geo:cube" "overrideDisplayType" " 2"
		2 "|Main|geo1|geo:cube" "overrideEnabled" " 1"
		2 "|Main|geo1|geo:cube|geo:cubeShape" "intermediateObject" " 1"
		5 3 "geoRN" "|Main|geo1|geo:sphere|geo:sphereShape.worldMesh" "geoRN.placeHolderList[1]" 
		""
		5 3 "geoRN" "|Main|geo1|geo:cube|geo:cubeShape.worldMesh" "geoRN.placeHolderList[2]" 
		""
		5 4 "geoRN" "geo:lambert2SG.dagSetMembers" "geoRN.placeHolderList[3]" 
		""
		5 4 "geoRN" "geo:lambert3SG.dagSetMembers" "geoRN.placeHolderList[4]" 
		"";
	setAttr ".ptag" -type "string" "";
lockNode -l 1 ;
createNode ffd -n "ffd1";
	rename -uid "789FF04A-4695-8BCE-3E2E-A9B5CF5C8F7D";
	setAttr -s 2 ".ip";
	setAttr -s 2 ".og";
	setAttr ".lo" yes;
createNode tweak -n "tweak1";
	rename -uid "36E42516-49AE-BDFA-C492-A697BCCAFC0E";
createNode tweak -n "tweak2";
	rename -uid "59154337-4763-8728-6F23-048E13998C2D";
createNode objectSet -n "ffd1Set";
	rename -uid "83A713D0-4B30-C432-22F3-8383A6B7AF01";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".vo" yes;
	setAttr -s 2 ".gn";
createNode groupId -n "ffd1GroupId";
	rename -uid "9AD3341A-4C16-76B9-60A4-B69EB3FEBC39";
	setAttr ".ihi" 0;
createNode groupParts -n "ffd1GroupParts";
	rename -uid "09F12123-49B4-6D0F-6A01-58AE247A90F3";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "vtx[*]";
createNode groupId -n "ffd1GroupId1";
	rename -uid "52577FAD-412F-6383-B448-2E85DFF9517F";
	setAttr ".ihi" 0;
createNode groupParts -n "ffd1GroupParts1";
	rename -uid "93910477-4038-866A-B7EA-FF938F2F97F7";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "vtx[*]";
createNode objectSet -n "tweakSet1";
	rename -uid "83315511-4ABA-7C19-23BE-E6892C1A56DA";
	setAttr ".ihi" 0;
	setAttr ".vo" yes;
createNode groupId -n "groupId3";
	rename -uid "2D8913A8-4286-A325-CD55-0C9E0CBD65FC";
	setAttr ".ihi" 0;
createNode groupParts -n "groupParts3";
	rename -uid "893FC5FD-4359-5FC9-130E-ADA888665AB2";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "vtx[*]";
createNode objectSet -n "tweakSet2";
	rename -uid "2950AF0F-48F1-10D4-A5D4-F994FF46637E";
	setAttr ".ihi" 0;
	setAttr ".vo" yes;
createNode groupId -n "groupId4";
	rename -uid "B9283336-4069-19D7-2555-3195CF43748D";
	setAttr ".ihi" 0;
createNode groupParts -n "groupParts4";
	rename -uid "57844D25-4023-003F-34E0-AE958579B2F1";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "vtx[*]";
createNode cluster -n "cluster1";
	rename -uid "411F1ABD-4E17-421B-F956-E498733A75CC";
	setAttr ".rel" yes;
	setAttr ".gm[0]" -type "matrix" 2.0000002384185791 0 0 0 0 2.8986517825046145 0 0
		 0 0 2.0000005960464478 0 -1.1920928955078125e-007 0.44932589125230726 -1.7881393432617188e-007 1;
createNode tweak -n "tweak3";
	rename -uid "11FB844B-4888-4F27-4E02-F6B8C51FF512";
createNode objectSet -n "cluster1Set";
	rename -uid "27BF7D4B-4C37-CAE7-C458-63ACD9F3A14F";
	setAttr ".ihi" 0;
	setAttr ".vo" yes;
createNode groupId -n "cluster1GroupId";
	rename -uid "D6712C30-424C-A262-20B2-AB8025404BCA";
	setAttr ".ihi" 0;
createNode groupParts -n "cluster1GroupParts";
	rename -uid "DF0C1093-49F6-F568-6445-00AC3121702E";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "pt[0:1][3:4][0:1]";
createNode objectSet -n "tweakSet3";
	rename -uid "C36824B7-422A-60EA-7ED8-1CAEDD405EEA";
	setAttr ".ihi" 0;
	setAttr ".vo" yes;
createNode groupId -n "groupId6";
	rename -uid "63E0A8B1-4573-5CD1-33E6-D0A5B548D202";
	setAttr ".ihi" 0;
createNode groupParts -n "groupParts6";
	rename -uid "A37561C8-4ED8-771E-F0E7-1987900DAECF";
	setAttr ".ihi" 0;
	setAttr ".ic" -type "componentList" 1 "pt[*][*][*]";
createNode makeNurbCircle -n "makeNurbCircle1";
	rename -uid "09A8EEEE-474E-5434-5375-CDAD15349B92";
	setAttr ".tol" 1e-006;
createNode transformGeometry -n "transformGeometry1";
	rename -uid "D2A368EE-4A91-7522-577A-80A3E2A8C4C7";
	setAttr ".txf" -type "matrix" 1 0 0 0 0 2.2204460492503131e-016 1 0 0 -1 2.2204460492503131e-016 0
		 0 2.0350758905225961 0 1;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "17E68652-48FC-62C6-36B6-2C9D8A3DB8BB";
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
	setAttr -s 4 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 6 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
	setAttr -s 2 ".r";
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
connectAttr "geoRN.phl[1]" "groupParts3.ig";
connectAttr "geoRN.phl[2]" "groupParts4.ig";
connectAttr "sphereShapeDeformed.iog" "geoRN.phl[3]";
connectAttr "cubeShapeDeformed.iog" "geoRN.phl[4]";
connectAttr "cluster1.og[0]" "ffd1LatticeShape.li";
connectAttr "tweak3.pl[0].cp[0]" "ffd1LatticeShape.twl";
connectAttr "cluster1GroupId.id" "ffd1LatticeShape.iog.og[0].gid";
connectAttr "cluster1Set.mwc" "ffd1LatticeShape.iog.og[0].gco";
connectAttr "groupId6.id" "ffd1LatticeShape.iog.og[1].gid";
connectAttr "tweakSet3.mwc" "ffd1LatticeShape.iog.og[1].gco";
connectAttr "cluster1Handle_parentConstraint1.ctx" "cluster1Handle.tx";
connectAttr "cluster1Handle_parentConstraint1.cty" "cluster1Handle.ty";
connectAttr "cluster1Handle_parentConstraint1.ctz" "cluster1Handle.tz";
connectAttr "cluster1Handle_parentConstraint1.crx" "cluster1Handle.rx";
connectAttr "cluster1Handle_parentConstraint1.cry" "cluster1Handle.ry";
connectAttr "cluster1Handle_parentConstraint1.crz" "cluster1Handle.rz";
connectAttr "cluster1Handle_scaleConstraint1.csx" "cluster1Handle.sx";
connectAttr "cluster1Handle_scaleConstraint1.csy" "cluster1Handle.sy";
connectAttr "cluster1Handle_scaleConstraint1.csz" "cluster1Handle.sz";
connectAttr "cluster1Handle.ro" "cluster1Handle_parentConstraint1.cro";
connectAttr "cluster1Handle.pim" "cluster1Handle_parentConstraint1.cpim";
connectAttr "cluster1Handle.rp" "cluster1Handle_parentConstraint1.crp";
connectAttr "cluster1Handle.rpt" "cluster1Handle_parentConstraint1.crt";
connectAttr "Second.t" "cluster1Handle_parentConstraint1.tg[0].tt";
connectAttr "Second.rp" "cluster1Handle_parentConstraint1.tg[0].trp";
connectAttr "Second.rpt" "cluster1Handle_parentConstraint1.tg[0].trt";
connectAttr "Second.r" "cluster1Handle_parentConstraint1.tg[0].tr";
connectAttr "Second.ro" "cluster1Handle_parentConstraint1.tg[0].tro";
connectAttr "Second.s" "cluster1Handle_parentConstraint1.tg[0].ts";
connectAttr "Second.pm" "cluster1Handle_parentConstraint1.tg[0].tpm";
connectAttr "cluster1Handle_parentConstraint1.w0" "cluster1Handle_parentConstraint1.tg[0].tw"
		;
connectAttr "cluster1Handle.pim" "cluster1Handle_scaleConstraint1.cpim";
connectAttr "Second.s" "cluster1Handle_scaleConstraint1.tg[0].ts";
connectAttr "Second.pm" "cluster1Handle_scaleConstraint1.tg[0].tpm";
connectAttr "cluster1Handle_scaleConstraint1.w0" "cluster1Handle_scaleConstraint1.tg[0].tw"
		;
connectAttr "transformGeometry1.og" "SecondShape.cr";
connectAttr "ffd1GroupId1.id" "cubeShapeDeformed.iog.og[0].gid";
connectAttr "ffd1Set.mwc" "cubeShapeDeformed.iog.og[0].gco";
connectAttr "groupId4.id" "cubeShapeDeformed.iog.og[1].gid";
connectAttr "tweakSet2.mwc" "cubeShapeDeformed.iog.og[1].gco";
connectAttr "ffd1.og[1]" "cubeShapeDeformed.i";
connectAttr "tweak2.vl[0].vt[0]" "cubeShapeDeformed.twl";
connectAttr "ffd1GroupId.id" "sphereShapeDeformed.iog.og[0].gid";
connectAttr "ffd1Set.mwc" "sphereShapeDeformed.iog.og[0].gco";
connectAttr "groupId3.id" "sphereShapeDeformed.iog.og[1].gid";
connectAttr "tweakSet1.mwc" "sphereShapeDeformed.iog.og[1].gco";
connectAttr "ffd1.og[0]" "sphereShapeDeformed.i";
connectAttr "tweak1.vl[0].vt[0]" "sphereShapeDeformed.twl";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "geo1.msg" "geoRN.asn[0]";
connectAttr "geoRNfosterParent1.msg" "geoRN.fp";
connectAttr "ffd1GroupParts.og" "ffd1.ip[0].ig";
connectAttr "ffd1GroupId.id" "ffd1.ip[0].gi";
connectAttr "ffd1GroupParts1.og" "ffd1.ip[1].ig";
connectAttr "ffd1GroupId1.id" "ffd1.ip[1].gi";
connectAttr "ffd1LatticeShape.wm" "ffd1.dlm";
connectAttr "ffd1LatticeShape.lo" "ffd1.dlp";
connectAttr "ffd1BaseShape.wm" "ffd1.blm";
connectAttr "groupParts3.og" "tweak1.ip[0].ig";
connectAttr "groupId3.id" "tweak1.ip[0].gi";
connectAttr "groupParts4.og" "tweak2.ip[0].ig";
connectAttr "groupId4.id" "tweak2.ip[0].gi";
connectAttr "ffd1GroupId.msg" "ffd1Set.gn" -na;
connectAttr "ffd1GroupId1.msg" "ffd1Set.gn" -na;
connectAttr "sphereShapeDeformed.iog.og[0]" "ffd1Set.dsm" -na;
connectAttr "cubeShapeDeformed.iog.og[0]" "ffd1Set.dsm" -na;
connectAttr "ffd1.msg" "ffd1Set.ub[0]";
connectAttr "tweak1.og[0]" "ffd1GroupParts.ig";
connectAttr "ffd1GroupId.id" "ffd1GroupParts.gi";
connectAttr "tweak2.og[0]" "ffd1GroupParts1.ig";
connectAttr "ffd1GroupId1.id" "ffd1GroupParts1.gi";
connectAttr "groupId3.msg" "tweakSet1.gn" -na;
connectAttr "sphereShapeDeformed.iog.og[1]" "tweakSet1.dsm" -na;
connectAttr "tweak1.msg" "tweakSet1.ub[0]";
connectAttr "groupId3.id" "groupParts3.gi";
connectAttr "groupId4.msg" "tweakSet2.gn" -na;
connectAttr "cubeShapeDeformed.iog.og[1]" "tweakSet2.dsm" -na;
connectAttr "tweak2.msg" "tweakSet2.ub[0]";
connectAttr "groupId4.id" "groupParts4.gi";
connectAttr "cluster1GroupParts.og" "cluster1.ip[0].ig";
connectAttr "cluster1GroupId.id" "cluster1.ip[0].gi";
connectAttr "cluster1Handle.wm" "cluster1.ma";
connectAttr "cluster1HandleShape.x" "cluster1.x";
connectAttr "groupParts6.og" "tweak3.ip[0].ig";
connectAttr "groupId6.id" "tweak3.ip[0].gi";
connectAttr "cluster1GroupId.msg" "cluster1Set.gn" -na;
connectAttr "ffd1LatticeShape.iog.og[0]" "cluster1Set.dsm" -na;
connectAttr "cluster1.msg" "cluster1Set.ub[0]";
connectAttr "tweak3.og[0]" "cluster1GroupParts.ig";
connectAttr "cluster1GroupId.id" "cluster1GroupParts.gi";
connectAttr "groupId6.msg" "tweakSet3.gn" -na;
connectAttr "ffd1LatticeShape.iog.og[1]" "tweakSet3.dsm" -na;
connectAttr "tweak3.msg" "tweakSet3.ub[0]";
connectAttr "ffd1LatticeShapeOrig.wl" "groupParts6.ig";
connectAttr "groupId6.id" "groupParts6.gi";
connectAttr "makeNurbCircle1.oc" "transformGeometry1.ig";
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of testRig.ma
