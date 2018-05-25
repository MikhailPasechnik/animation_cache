//Maya ASCII 2017ff05 scene
//Name: testAnimation.ma
//Last modified: Mon, May 21, 2018 07:15:29 PM
//Codeset: 1251
file -rdi 1 -ns "rig" -rfn "rigRN" -op "v=0;" -typ "mayaAscii" "testRig.ma";
file -rdi 2 -ns "geo" -rfn "rig:geoRN" -op "v=0;" -typ "mayaAscii" "testGeometry.ma";
file -rdi 1 -ns "gpu" -rfn "gpuRN" -op "v=0;" -typ "mayaAscii" "testGpuCache.ma";
file -r -ns "rig" -dr 1 -rfn "rigRN" -op "v=0;" -typ "mayaAscii" "testRig.ma";
file -r -ns "gpu" -dr 1 -rfn "gpuRN" -op "v=0;" -typ "mayaAscii" "testGpuCache.ma";
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
	rename -uid "2E1619B8-4E4E-1E0E-E0BF-8CA3E1258F1C";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 9.9817895190208539 8.5903173415514065 10.481127475665982 ;
	setAttr ".r" -type "double3" -33.938352729602528 42.200000000000244 2.1466893546597291e-015 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "AA1BF41F-4BCD-A92F-B5CB-EDA415AEE539";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 16.915294694656261;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "D6FF0A82-4BE2-DF03-2963-31BA9811D849";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "0F6022F7-4982-1C3B-561A-3A9756D9016D";
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
	rename -uid "A0B6E5C7-442D-69A1-67B8-008C5AD94891";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "BD21B60B-4014-97E5-824F-B0BA8169D744";
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
	rename -uid "DE7DDFCD-47B5-D668-FA33-6F9571694260";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "27BE9655-4098-3F89-17A8-7C9165264DD3";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "testCamera";
	rename -uid "905B6A82-457C-B9B4-3AB6-9DB637921A8F";
createNode camera -n "testCameraShape" -p "testCamera";
	rename -uid "5B2DE573-49B1-139F-1143-149401C4A995";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".cap" -type "double2" 1.4173 0.9449 ;
	setAttr ".se" yes;
	setAttr ".ff" 0;
	setAttr ".ovr" 1.3;
	setAttr ".coi" 25.398733430926093;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "camera1";
	setAttr ".den" -type "string" "camera1_depth";
	setAttr ".man" -type "string" "camera1_mask";
	setAttr ".tp" -type "double3" 0.65610416608001865 -0.10622120866954687 -0.50149281292376324 ;
	setAttr ".dfg" yes;
createNode transform -n "localNodes";
	rename -uid "69C1F480-4EC1-3A26-B187-EC9CA9A0A3BF";
createNode transform -n "pPlane1" -p "localNodes";
	rename -uid "1B8C3FDB-4B1B-2312-883A-9EAB51E27743";
	setAttr ".t" -type "double3" 0 -1.0779183759818687 0 ;
	setAttr ".s" -type "double3" 13.002639481419047 1 13.002639481419047 ;
createNode mesh -n "pPlaneShape1" -p "pPlane1";
	rename -uid "DE0788F5-4CE5-6124-8AA6-5AB7D1CB0D7D";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 121 ".uvst[0].uvsp[0:120]" -type "float2" 0 0 0.1 0 0.2 0 0.30000001
		 0 0.40000001 0 0.5 0 0.60000002 0 0.69999999 0 0.80000001 0 0.90000004 0 1 0 0 0.1
		 0.1 0.1 0.2 0.1 0.30000001 0.1 0.40000001 0.1 0.5 0.1 0.60000002 0.1 0.69999999 0.1
		 0.80000001 0.1 0.90000004 0.1 1 0.1 0 0.2 0.1 0.2 0.2 0.2 0.30000001 0.2 0.40000001
		 0.2 0.5 0.2 0.60000002 0.2 0.69999999 0.2 0.80000001 0.2 0.90000004 0.2 1 0.2 0 0.30000001
		 0.1 0.30000001 0.2 0.30000001 0.30000001 0.30000001 0.40000001 0.30000001 0.5 0.30000001
		 0.60000002 0.30000001 0.69999999 0.30000001 0.80000001 0.30000001 0.90000004 0.30000001
		 1 0.30000001 0 0.40000001 0.1 0.40000001 0.2 0.40000001 0.30000001 0.40000001 0.40000001
		 0.40000001 0.5 0.40000001 0.60000002 0.40000001 0.69999999 0.40000001 0.80000001
		 0.40000001 0.90000004 0.40000001 1 0.40000001 0 0.5 0.1 0.5 0.2 0.5 0.30000001 0.5
		 0.40000001 0.5 0.5 0.5 0.60000002 0.5 0.69999999 0.5 0.80000001 0.5 0.90000004 0.5
		 1 0.5 0 0.60000002 0.1 0.60000002 0.2 0.60000002 0.30000001 0.60000002 0.40000001
		 0.60000002 0.5 0.60000002 0.60000002 0.60000002 0.69999999 0.60000002 0.80000001
		 0.60000002 0.90000004 0.60000002 1 0.60000002 0 0.69999999 0.1 0.69999999 0.2 0.69999999
		 0.30000001 0.69999999 0.40000001 0.69999999 0.5 0.69999999 0.60000002 0.69999999
		 0.69999999 0.69999999 0.80000001 0.69999999 0.90000004 0.69999999 1 0.69999999 0
		 0.80000001 0.1 0.80000001 0.2 0.80000001 0.30000001 0.80000001 0.40000001 0.80000001
		 0.5 0.80000001 0.60000002 0.80000001 0.69999999 0.80000001 0.80000001 0.80000001
		 0.90000004 0.80000001 1 0.80000001 0 0.90000004 0.1 0.90000004 0.2 0.90000004 0.30000001
		 0.90000004 0.40000001 0.90000004 0.5 0.90000004 0.60000002 0.90000004 0.69999999
		 0.90000004 0.80000001 0.90000004 0.90000004 0.90000004 1 0.90000004 0 1 0.1 1 0.2
		 1 0.30000001 1 0.40000001 1 0.5 1 0.60000002 1 0.69999999 1 0.80000001 1 0.90000004
		 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Ambient+Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 121 ".vt[0:120]"  -0.5 -1.110223e-016 0.5 -0.40000001 -1.110223e-016 0.5
		 -0.30000001 -1.110223e-016 0.5 -0.19999999 -1.110223e-016 0.5 -0.099999994 -1.110223e-016 0.5
		 0 -1.110223e-016 0.5 0.10000002 -1.110223e-016 0.5 0.19999999 -1.110223e-016 0.5
		 0.30000001 -1.110223e-016 0.5 0.40000004 -1.110223e-016 0.5 0.5 -1.110223e-016 0.5
		 -0.5 -8.8817843e-017 0.40000001 -0.40000001 -8.8817843e-017 0.40000001 -0.30000001 -8.8817843e-017 0.40000001
		 -0.19999999 -8.8817843e-017 0.40000001 -0.099999994 -8.8817843e-017 0.40000001 0 -8.8817843e-017 0.40000001
		 0.10000002 -8.8817843e-017 0.40000001 0.19999999 -8.8817843e-017 0.40000001 0.30000001 -8.8817843e-017 0.40000001
		 0.40000004 -8.8817843e-017 0.40000001 0.5 -8.8817843e-017 0.40000001 -0.5 -6.6613384e-017 0.30000001
		 -0.40000001 -6.6613384e-017 0.30000001 -0.30000001 -6.6613384e-017 0.30000001 -0.19999999 -6.6613384e-017 0.30000001
		 -0.099999994 -6.6613384e-017 0.30000001 0 -6.6613384e-017 0.30000001 0.10000002 -6.6613384e-017 0.30000001
		 0.19999999 -6.6613384e-017 0.30000001 0.30000001 -6.6613384e-017 0.30000001 0.40000004 -6.6613384e-017 0.30000001
		 0.5 -6.6613384e-017 0.30000001 -0.5 -4.4408918e-017 0.19999999 -0.40000001 -4.4408918e-017 0.19999999
		 -0.30000001 -4.4408918e-017 0.19999999 -0.19999999 -4.4408918e-017 0.19999999 -0.099999994 -4.4408918e-017 0.19999999
		 0 -4.4408918e-017 0.19999999 0.10000002 -4.4408918e-017 0.19999999 0.19999999 -4.4408918e-017 0.19999999
		 0.30000001 -4.4408918e-017 0.19999999 0.40000004 -4.4408918e-017 0.19999999 0.5 -4.4408918e-017 0.19999999
		 -0.5 -2.2204459e-017 0.099999994 -0.40000001 -2.2204459e-017 0.099999994 -0.30000001 -2.2204459e-017 0.099999994
		 -0.19999999 -2.2204459e-017 0.099999994 -0.099999994 -2.2204459e-017 0.099999994
		 0 -2.2204459e-017 0.099999994 0.10000002 -2.2204459e-017 0.099999994 0.19999999 -2.2204459e-017 0.099999994
		 0.30000001 -2.2204459e-017 0.099999994 0.40000004 -2.2204459e-017 0.099999994 0.5 -2.2204459e-017 0.099999994
		 -0.5 0 0 -0.40000001 0 0 -0.30000001 0 0 -0.19999999 0 0 -0.099999994 0 0 0 0 0 0.10000002 0 0
		 0.19999999 0 0 0.30000001 0 0 0.40000004 0 0 0.5 0 0 -0.5 2.2204466e-017 -0.10000002
		 -0.40000001 2.2204466e-017 -0.10000002 -0.30000001 2.2204466e-017 -0.10000002 -0.19999999 2.2204466e-017 -0.10000002
		 -0.099999994 2.2204466e-017 -0.10000002 0 2.2204466e-017 -0.10000002 0.10000002 2.2204466e-017 -0.10000002
		 0.19999999 2.2204466e-017 -0.10000002 0.30000001 2.2204466e-017 -0.10000002 0.40000004 2.2204466e-017 -0.10000002
		 0.5 2.2204466e-017 -0.10000002 -0.5 4.4408918e-017 -0.19999999 -0.40000001 4.4408918e-017 -0.19999999
		 -0.30000001 4.4408918e-017 -0.19999999 -0.19999999 4.4408918e-017 -0.19999999 -0.099999994 4.4408918e-017 -0.19999999
		 0 4.4408918e-017 -0.19999999 0.10000002 4.4408918e-017 -0.19999999 0.19999999 4.4408918e-017 -0.19999999
		 0.30000001 4.4408918e-017 -0.19999999 0.40000004 4.4408918e-017 -0.19999999 0.5 4.4408918e-017 -0.19999999
		 -0.5 6.6613384e-017 -0.30000001 -0.40000001 6.6613384e-017 -0.30000001 -0.30000001 6.6613384e-017 -0.30000001
		 -0.19999999 6.6613384e-017 -0.30000001 -0.099999994 6.6613384e-017 -0.30000001 0 6.6613384e-017 -0.30000001
		 0.10000002 6.6613384e-017 -0.30000001 0.19999999 6.6613384e-017 -0.30000001 0.30000001 6.6613384e-017 -0.30000001
		 0.40000004 6.6613384e-017 -0.30000001 0.5 6.6613384e-017 -0.30000001 -0.5 8.881785e-017 -0.40000004
		 -0.40000001 8.881785e-017 -0.40000004 -0.30000001 8.881785e-017 -0.40000004 -0.19999999 8.881785e-017 -0.40000004
		 -0.099999994 8.881785e-017 -0.40000004 0 8.881785e-017 -0.40000004 0.10000002 8.881785e-017 -0.40000004
		 0.19999999 8.881785e-017 -0.40000004 0.30000001 8.881785e-017 -0.40000004 0.40000004 8.881785e-017 -0.40000004
		 0.5 8.881785e-017 -0.40000004 -0.5 1.110223e-016 -0.5 -0.40000001 1.110223e-016 -0.5
		 -0.30000001 1.110223e-016 -0.5 -0.19999999 1.110223e-016 -0.5 -0.099999994 1.110223e-016 -0.5
		 0 1.110223e-016 -0.5 0.10000002 1.110223e-016 -0.5 0.19999999 1.110223e-016 -0.5
		 0.30000001 1.110223e-016 -0.5 0.40000004 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 220 ".ed";
	setAttr ".ed[0:165]"  0 1 0 0 11 0 1 2 0 1 12 1 2 3 0 2 13 1 3 4 0 3 14 1
		 4 5 0 4 15 1 5 6 0 5 16 1 6 7 0 6 17 1 7 8 0 7 18 1 8 9 0 8 19 1 9 10 0 9 20 1 10 21 0
		 11 12 1 11 22 0 12 13 1 12 23 1 13 14 1 13 24 1 14 15 1 14 25 1 15 16 1 15 26 1 16 17 1
		 16 27 1 17 18 1 17 28 1 18 19 1 18 29 1 19 20 1 19 30 1 20 21 1 20 31 1 21 32 0 22 23 1
		 22 33 0 23 24 1 23 34 1 24 25 1 24 35 1 25 26 1 25 36 1 26 27 1 26 37 1 27 28 1 27 38 1
		 28 29 1 28 39 1 29 30 1 29 40 1 30 31 1 30 41 1 31 32 1 31 42 1 32 43 0 33 34 1 33 44 0
		 34 35 1 34 45 1 35 36 1 35 46 1 36 37 1 36 47 1 37 38 1 37 48 1 38 39 1 38 49 1 39 40 1
		 39 50 1 40 41 1 40 51 1 41 42 1 41 52 1 42 43 1 42 53 1 43 54 0 44 45 1 44 55 0 45 46 1
		 45 56 1 46 47 1 46 57 1 47 48 1 47 58 1 48 49 1 48 59 1 49 50 1 49 60 1 50 51 1 50 61 1
		 51 52 1 51 62 1 52 53 1 52 63 1 53 54 1 53 64 1 54 65 0 55 56 1 55 66 0 56 57 1 56 67 1
		 57 58 1 57 68 1 58 59 1 58 69 1 59 60 1 59 70 1 60 61 1 60 71 1 61 62 1 61 72 1 62 63 1
		 62 73 1 63 64 1 63 74 1 64 65 1 64 75 1 65 76 0 66 67 1 66 77 0 67 68 1 67 78 1 68 69 1
		 68 79 1 69 70 1 69 80 1 70 71 1 70 81 1 71 72 1 71 82 1 72 73 1 72 83 1 73 74 1 73 84 1
		 74 75 1 74 85 1 75 76 1 75 86 1 76 87 0 77 78 1 77 88 0 78 79 1 78 89 1 79 80 1 79 90 1
		 80 81 1 80 91 1 81 82 1 81 92 1 82 83 1 82 93 1 83 84 1 83 94 1 84 85 1 84 95 1 85 86 1
		 85 96 1 86 87 1;
	setAttr ".ed[166:219]" 86 97 1 87 98 0 88 89 1 88 99 0 89 90 1 89 100 1 90 91 1
		 90 101 1 91 92 1 91 102 1 92 93 1 92 103 1 93 94 1 93 104 1 94 95 1 94 105 1 95 96 1
		 95 106 1 96 97 1 96 107 1 97 98 1 97 108 1 98 109 0 99 100 1 99 110 0 100 101 1 100 111 1
		 101 102 1 101 112 1 102 103 1 102 113 1 103 104 1 103 114 1 104 105 1 104 115 1 105 106 1
		 105 116 1 106 107 1 106 117 1 107 108 1 107 118 1 108 109 1 108 119 1 109 120 0 110 111 0
		 111 112 0 112 113 0 113 114 0 114 115 0 115 116 0 116 117 0 117 118 0 118 119 0 119 120 0;
	setAttr -s 100 -ch 400 ".fc[0:99]" -type "polyFaces" 
		f 4 0 3 -22 -2
		mu 0 4 0 1 12 11
		f 4 2 5 -24 -4
		mu 0 4 1 2 13 12
		f 4 4 7 -26 -6
		mu 0 4 2 3 14 13
		f 4 6 9 -28 -8
		mu 0 4 3 4 15 14
		f 4 8 11 -30 -10
		mu 0 4 4 5 16 15
		f 4 10 13 -32 -12
		mu 0 4 5 6 17 16
		f 4 12 15 -34 -14
		mu 0 4 6 7 18 17
		f 4 14 17 -36 -16
		mu 0 4 7 8 19 18
		f 4 16 19 -38 -18
		mu 0 4 8 9 20 19
		f 4 18 20 -40 -20
		mu 0 4 9 10 21 20
		f 4 21 24 -43 -23
		mu 0 4 11 12 23 22
		f 4 23 26 -45 -25
		mu 0 4 12 13 24 23
		f 4 25 28 -47 -27
		mu 0 4 13 14 25 24
		f 4 27 30 -49 -29
		mu 0 4 14 15 26 25
		f 4 29 32 -51 -31
		mu 0 4 15 16 27 26
		f 4 31 34 -53 -33
		mu 0 4 16 17 28 27
		f 4 33 36 -55 -35
		mu 0 4 17 18 29 28
		f 4 35 38 -57 -37
		mu 0 4 18 19 30 29
		f 4 37 40 -59 -39
		mu 0 4 19 20 31 30
		f 4 39 41 -61 -41
		mu 0 4 20 21 32 31
		f 4 42 45 -64 -44
		mu 0 4 22 23 34 33
		f 4 44 47 -66 -46
		mu 0 4 23 24 35 34
		f 4 46 49 -68 -48
		mu 0 4 24 25 36 35
		f 4 48 51 -70 -50
		mu 0 4 25 26 37 36
		f 4 50 53 -72 -52
		mu 0 4 26 27 38 37
		f 4 52 55 -74 -54
		mu 0 4 27 28 39 38
		f 4 54 57 -76 -56
		mu 0 4 28 29 40 39
		f 4 56 59 -78 -58
		mu 0 4 29 30 41 40
		f 4 58 61 -80 -60
		mu 0 4 30 31 42 41
		f 4 60 62 -82 -62
		mu 0 4 31 32 43 42
		f 4 63 66 -85 -65
		mu 0 4 33 34 45 44
		f 4 65 68 -87 -67
		mu 0 4 34 35 46 45
		f 4 67 70 -89 -69
		mu 0 4 35 36 47 46
		f 4 69 72 -91 -71
		mu 0 4 36 37 48 47
		f 4 71 74 -93 -73
		mu 0 4 37 38 49 48
		f 4 73 76 -95 -75
		mu 0 4 38 39 50 49
		f 4 75 78 -97 -77
		mu 0 4 39 40 51 50
		f 4 77 80 -99 -79
		mu 0 4 40 41 52 51
		f 4 79 82 -101 -81
		mu 0 4 41 42 53 52
		f 4 81 83 -103 -83
		mu 0 4 42 43 54 53
		f 4 84 87 -106 -86
		mu 0 4 44 45 56 55
		f 4 86 89 -108 -88
		mu 0 4 45 46 57 56
		f 4 88 91 -110 -90
		mu 0 4 46 47 58 57
		f 4 90 93 -112 -92
		mu 0 4 47 48 59 58
		f 4 92 95 -114 -94
		mu 0 4 48 49 60 59
		f 4 94 97 -116 -96
		mu 0 4 49 50 61 60
		f 4 96 99 -118 -98
		mu 0 4 50 51 62 61
		f 4 98 101 -120 -100
		mu 0 4 51 52 63 62
		f 4 100 103 -122 -102
		mu 0 4 52 53 64 63
		f 4 102 104 -124 -104
		mu 0 4 53 54 65 64
		f 4 105 108 -127 -107
		mu 0 4 55 56 67 66
		f 4 107 110 -129 -109
		mu 0 4 56 57 68 67
		f 4 109 112 -131 -111
		mu 0 4 57 58 69 68
		f 4 111 114 -133 -113
		mu 0 4 58 59 70 69
		f 4 113 116 -135 -115
		mu 0 4 59 60 71 70
		f 4 115 118 -137 -117
		mu 0 4 60 61 72 71
		f 4 117 120 -139 -119
		mu 0 4 61 62 73 72
		f 4 119 122 -141 -121
		mu 0 4 62 63 74 73
		f 4 121 124 -143 -123
		mu 0 4 63 64 75 74
		f 4 123 125 -145 -125
		mu 0 4 64 65 76 75
		f 4 126 129 -148 -128
		mu 0 4 66 67 78 77
		f 4 128 131 -150 -130
		mu 0 4 67 68 79 78
		f 4 130 133 -152 -132
		mu 0 4 68 69 80 79
		f 4 132 135 -154 -134
		mu 0 4 69 70 81 80
		f 4 134 137 -156 -136
		mu 0 4 70 71 82 81
		f 4 136 139 -158 -138
		mu 0 4 71 72 83 82
		f 4 138 141 -160 -140
		mu 0 4 72 73 84 83
		f 4 140 143 -162 -142
		mu 0 4 73 74 85 84
		f 4 142 145 -164 -144
		mu 0 4 74 75 86 85
		f 4 144 146 -166 -146
		mu 0 4 75 76 87 86
		f 4 147 150 -169 -149
		mu 0 4 77 78 89 88
		f 4 149 152 -171 -151
		mu 0 4 78 79 90 89
		f 4 151 154 -173 -153
		mu 0 4 79 80 91 90
		f 4 153 156 -175 -155
		mu 0 4 80 81 92 91
		f 4 155 158 -177 -157
		mu 0 4 81 82 93 92
		f 4 157 160 -179 -159
		mu 0 4 82 83 94 93
		f 4 159 162 -181 -161
		mu 0 4 83 84 95 94
		f 4 161 164 -183 -163
		mu 0 4 84 85 96 95
		f 4 163 166 -185 -165
		mu 0 4 85 86 97 96
		f 4 165 167 -187 -167
		mu 0 4 86 87 98 97
		f 4 168 171 -190 -170
		mu 0 4 88 89 100 99
		f 4 170 173 -192 -172
		mu 0 4 89 90 101 100
		f 4 172 175 -194 -174
		mu 0 4 90 91 102 101
		f 4 174 177 -196 -176
		mu 0 4 91 92 103 102
		f 4 176 179 -198 -178
		mu 0 4 92 93 104 103
		f 4 178 181 -200 -180
		mu 0 4 93 94 105 104
		f 4 180 183 -202 -182
		mu 0 4 94 95 106 105
		f 4 182 185 -204 -184
		mu 0 4 95 96 107 106
		f 4 184 187 -206 -186
		mu 0 4 96 97 108 107
		f 4 186 188 -208 -188
		mu 0 4 97 98 109 108
		f 4 189 192 -211 -191
		mu 0 4 99 100 111 110
		f 4 191 194 -212 -193
		mu 0 4 100 101 112 111
		f 4 193 196 -213 -195
		mu 0 4 101 102 113 112
		f 4 195 198 -214 -197
		mu 0 4 102 103 114 113
		f 4 197 200 -215 -199
		mu 0 4 103 104 115 114
		f 4 199 202 -216 -201
		mu 0 4 104 105 116 115
		f 4 201 204 -217 -203
		mu 0 4 105 106 117 116
		f 4 203 206 -218 -205
		mu 0 4 106 107 118 117
		f 4 205 208 -219 -207
		mu 0 4 107 108 119 118
		f 4 207 209 -220 -209
		mu 0 4 108 109 120 119;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
createNode transform -n "Main";
	rename -uid "43CC13C1-4563-1117-C18A-4DACDE7FE8E5";
	setAttr ".t" -type "double3" -4.3185759151818459 -0.39108067250416334 -0.4178170452577819 ;
	setAttr ".s" -type "double3" 0.41110223405082336 0.49332268086098813 0.41110223405082336 ;
createNode transform -n "testGpuCache" -p "Main";
	rename -uid "CCDBE33A-4F8E-1DA6-F3E8-8FB2D4029D3E";
	setAttr ".ovdt" 1;
	setAttr ".ove" yes;
createNode transform -n "Main1";
	rename -uid "E1F4DC6B-4989-95FD-C82C-37B76A0AA160";
	setAttr ".t" -type "double3" 6.3340441259148994 -1.0193543151079372 -6.2439704890337904 ;
	setAttr ".s" -type "double3" 1 1.44 1 ;
createNode transform -n "testGpuCache1" -p "Main1";
	rename -uid "5066625A-48F3-8042-D163-FFA141DFD3F3";
	setAttr ".ovdt" 1;
	setAttr ".ove" yes;
createNode transform -n "Main2";
	rename -uid "77D949C0-44BF-AEDB-C3CD-DA9C0A7B1DEC";
	setAttr ".t" -type "double3" -3.3585262071681115 -0.96111635958565045 -5.6592584597987967 ;
	setAttr ".s" -type "double3" 1.9330535878034283 1.728 1 ;
createNode transform -n "testGpuCache2" -p "Main2";
	rename -uid "3CEFA58E-45E0-3424-BB96-5F8F5F1CD9F8";
	setAttr ".ovdt" 1;
	setAttr ".ove" yes;
createNode transform -n "Main3";
	rename -uid "82F55F4C-4143-47D8-F8D3-78AE91A6E981";
	setAttr ".t" -type "double3" 0.86512409157260384 -1.0379433767703312 4.2391138406566657 ;
	setAttr ".s" -type "double3" 1.6771760008561281 2.0736 1.6771760008561281 ;
createNode transform -n "testGpuCache3" -p "Main3";
	rename -uid "4C23C133-4570-F6A7-7A3B-BE9E60DED38F";
	setAttr ".ovdt" 1;
	setAttr ".ove" yes;
createNode lightLinker -s -n "lightLinker1";
	rename -uid "CB1821CE-4086-0531-EF1D-2B913E83EDCC";
	setAttr -s 4 ".lnk";
	setAttr -s 4 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "90B006D1-422D-E126-AA9A-07B931817B44";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "3499F0CB-43D9-6AD2-A5DA-5ABF72DE3AFC";
createNode displayLayerManager -n "layerManager";
	rename -uid "D0CA867A-45F1-D1F1-0096-199F1E2554DC";
createNode displayLayer -n "defaultLayer";
	rename -uid "C62F4DEB-4F27-9D58-FA55-718A9582690A";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "6E89F19C-4358-8A76-E1AE-D9B52AC86663";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "AE8D8E22-4EAA-41BE-3781-36B15EB11599";
	setAttr ".g" yes;
createNode reference -n "rigRN";
	rename -uid "DA3540FD-4537-4D98-22B5-D18BEC4B7337";
	setAttr -s 20 ".phl";
	setAttr ".phl[1]" 0;
	setAttr ".phl[2]" 0;
	setAttr ".phl[3]" 0;
	setAttr ".phl[4]" 0;
	setAttr ".phl[5]" 0;
	setAttr ".phl[6]" 0;
	setAttr ".phl[7]" 0;
	setAttr ".phl[8]" 0;
	setAttr ".phl[9]" 0;
	setAttr ".phl[10]" 0;
	setAttr ".phl[11]" 0;
	setAttr ".phl[12]" 0;
	setAttr ".phl[13]" 0;
	setAttr ".phl[14]" 0;
	setAttr ".phl[15]" 0;
	setAttr ".phl[16]" 0;
	setAttr ".phl[17]" 0;
	setAttr ".phl[18]" 0;
	setAttr ".phl[19]" 0;
	setAttr ".phl[20]" 0;
	setAttr ".ed" -type "dataReferenceEdits" 
		"rigRN"
		"rigRN" 0
		"rig:geoRN" 0
		"rigRN" 50
		2 "|rig:Main" "translate" " -type \"double3\" 0 0 1.0247171030616335"
		2 "|rig:Main" "translateX" " -av"
		2 "|rig:Main" "translateY" " -av"
		2 "|rig:Main" "translateZ" " -av"
		2 "|rig:Main" "rotate" " -type \"double3\" -21.118105070645036 0 0"
		2 "|rig:Main" "rotateX" " -av"
		2 "|rig:Main" "rotateY" " -av"
		2 "|rig:Main" "rotateZ" " -av"
		2 "|rig:Main" "scale" " -type \"double3\" 1 0.85876646258476541 1"
		2 "|rig:Main" "scaleY" " -av"
		2 "|rig:Main|rig:cluster1Handle" "translate" " -type \"double3\" 1.1920928955078125e-007 -0.20723624102662175 -0.35103959940933105"
		
		2 "|rig:Main|rig:cluster1Handle" "translateX" " -av"
		2 "|rig:Main|rig:cluster1Handle" "translateY" " -av"
		2 "|rig:Main|rig:cluster1Handle" "translateZ" " -av"
		2 "|rig:Main|rig:Second" "translate" " -type \"double3\" 0 -0.70599182185768017 -0.35103977822326521"
		
		2 "|rig:Main|rig:Second" "translateX" " -av"
		2 "|rig:Main|rig:Second" "translateY" " -av"
		2 "|rig:Main|rig:Second" "translateZ" " -av"
		2 "|rig:Main|rig:Second" "rotate" " -type \"double3\" -15.547103420614274 0 0"
		
		2 "|rig:Main|rig:Second" "rotateX" " -av"
		2 "|rig:Main|rig:Second" "rotateY" " -av"
		2 "|rig:Main|rig:Second" "rotateZ" " -av"
		2 "|rig:Main|rig:Second" "scale" " -type \"double3\" 1.9358864627171335 1.9358864627171335 1.9358864627171335"
		
		2 "|rig:Main|rig:Second" "scaleX" " -av"
		2 "|rig:Main|rig:Second" "scaleY" " -av"
		2 "|rig:Main|rig:Second" "scaleZ" " -av"
		2 "|rig:geoRNfosterParent1|rig:cubeShapeDeformed" "dispResolution" " 3"
		2 "|rig:geoRNfosterParent1|rig:cubeShapeDeformed" "displaySmoothMesh" " 2"
		
		2 "|rig:geoRNfosterParent1|rig:sphereShapeDeformed" "dispResolution" " 3"
		
		2 "|rig:geoRNfosterParent1|rig:sphereShapeDeformed" "displaySmoothMesh" " 2"
		
		5 4 "rigRN" "|rig:Main.translateX" "rigRN.placeHolderList[1]" ""
		5 4 "rigRN" "|rig:Main.translateY" "rigRN.placeHolderList[2]" ""
		5 4 "rigRN" "|rig:Main.translateZ" "rigRN.placeHolderList[3]" ""
		5 4 "rigRN" "|rig:Main.rotateX" "rigRN.placeHolderList[4]" ""
		5 4 "rigRN" "|rig:Main.rotateY" "rigRN.placeHolderList[5]" ""
		5 4 "rigRN" "|rig:Main.rotateZ" "rigRN.placeHolderList[6]" ""
		5 4 "rigRN" "|rig:Main.scaleX" "rigRN.placeHolderList[7]" ""
		5 4 "rigRN" "|rig:Main.scaleY" "rigRN.placeHolderList[8]" ""
		5 4 "rigRN" "|rig:Main.scaleZ" "rigRN.placeHolderList[9]" ""
		5 4 "rigRN" "|rig:Main.visibility" "rigRN.placeHolderList[10]" ""
		5 4 "rigRN" "|rig:Main|rig:Second.translateX" "rigRN.placeHolderList[11]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.translateY" "rigRN.placeHolderList[12]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.translateZ" "rigRN.placeHolderList[13]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.rotateX" "rigRN.placeHolderList[14]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.rotateY" "rigRN.placeHolderList[15]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.rotateZ" "rigRN.placeHolderList[16]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.scaleX" "rigRN.placeHolderList[17]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.scaleY" "rigRN.placeHolderList[18]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.scaleZ" "rigRN.placeHolderList[19]" 
		""
		5 4 "rigRN" "|rig:Main|rig:Second.visibility" "rigRN.placeHolderList[20]" 
		"";
	setAttr ".ptag" -type "string" "";
lockNode -l 1 ;
createNode animCurveTL -n "Main_translateX";
	rename -uid "47C0D358-4781-F14E-0D92-F2A43EC35F47";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 10 0 20 0;
createNode animCurveTL -n "Main_translateY";
	rename -uid "9DF03099-4623-61F2-658C-C1AE17C6FE88";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 10 0 20 0;
createNode animCurveTL -n "Main_translateZ";
	rename -uid "1C948806-4156-B918-9FD8-EC8053721615";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 -3.5431431714731545 10 0 20 1.7676548709706807;
createNode animCurveTU -n "Main_visibility";
	rename -uid "C5F3080B-4C0E-9733-9A1B-C08F8DB6A100";
	setAttr ".tan" 9;
	setAttr -s 3 ".ktv[0:2]"  1 1 10 1 20 1;
	setAttr -s 3 ".kot[0:2]"  5 5 5;
createNode animCurveTA -n "Main_rotateX";
	rename -uid "54B52795-4B0F-7EF6-9050-F6BBCF43DFA9";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 36.225203125256989 10 0 20 -42.947798208893403;
createNode animCurveTA -n "Main_rotateY";
	rename -uid "D92B7E20-4AB2-B211-A6F7-DEAE4991E0E4";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 4.0400348378220654 10 0 20 0;
createNode animCurveTA -n "Main_rotateZ";
	rename -uid "BE457019-44F3-936B-B6CD-7EAAECC94C05";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 -1.42450338861362 10 0 20 0;
createNode animCurveTU -n "Main_scaleX";
	rename -uid "1877B83E-4009-C4C1-8A11-A6B4B3508FD2";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 10 1 20 1;
createNode animCurveTU -n "Main_scaleY";
	rename -uid "962E6D76-4E20-65B7-D47C-6B8865A6EDEA";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 10 0.78204701016167499 20 1;
createNode animCurveTU -n "Main_scaleZ";
	rename -uid "E8EC2983-4298-C04B-6C57-1A80B55F2673";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 10 1 20 1;
createNode animCurveTL -n "testCamera_translateX";
	rename -uid "AB9BD28C-4A3D-77BB-6A06-E29EA038EAA2";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 -4.9572039198009543 11 2.9102734988210854
		 20 4.3262036084710234;
createNode animCurveTL -n "testCamera_translateY";
	rename -uid "9FBF64A1-45BC-8791-C783-BAAE172F2296";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 6.5774765091218637 11 3.8122707819814106
		 20 3.4917435789241269;
createNode animCurveTL -n "testCamera_translateZ";
	rename -uid "11F291B4-4104-F56C-DED4-0F84CA8777CC";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 6.2788769622137908 11 3.3571998882384513
		 20 -1.2360168116765873;
createNode animCurveTU -n "testCamera_visibility";
	rename -uid "F0E7C59D-4AB3-ED48-A6BD-21862541330F";
	setAttr ".tan" 9;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 1 20 1;
	setAttr -s 3 ".kot[0:2]"  5 5 5;
createNode animCurveTA -n "testCamera_rotateX";
	rename -uid "FF058356-40AC-29F2-7B63-1A8BF8A7BB38";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 -35.998730024337064 11 -33.085871712119825
		 20 -30.598920520688946;
createNode animCurveTA -n "testCamera_rotateY";
	rename -uid "F8EB2529-427B-DA7E-5576-21B279DC88B2";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 -39.600000000001145 11 37.647412159206333
		 20 103.59999999999997;
createNode animCurveTA -n "testCamera_rotateZ";
	rename -uid "1C99AEAB-408C-FDFB-180E-76B7B42C0BC7";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 11 0 20 0;
createNode animCurveTU -n "testCamera_scaleX";
	rename -uid "F0D9C88C-4038-BE59-8AC8-4686CEB740CA";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 1 20 1;
createNode animCurveTU -n "testCamera_scaleY";
	rename -uid "ACD7D3C2-4874-14ED-BDCA-CBBBA99A45A6";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 1 20 1;
createNode animCurveTU -n "testCamera_scaleZ";
	rename -uid "209A1170-46BB-2416-7B91-7D8ECE5EB555";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 1 20 1;
createNode expression -n "expression1";
	rename -uid "3620F244-4025-66ED-C732-9192C78ECE32";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0] = noise(frame/3)/100;";
createNode expression -n "expression2";
	rename -uid "72596747-47B8-1FD4-F573-48952EE29B6F";
	setAttr -k on ".nds";
	setAttr ".ixp" -type "string" ".O[0] = noise(frame/3)/100;";
createNode animCurveTA -n "Second_rotateX";
	rename -uid "6949E4C4-408C-070D-EDED-B8874FC14AF6";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 -49.078948383947747 10 0 16 -25.758723621881366
		 20 -39.751116700434217;
createNode animCurveTA -n "Second_rotateY";
	rename -uid "07FC48FC-4B89-619A-D801-F2AF7002F7B6";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 0 10 0 16 0 20 0;
createNode animCurveTA -n "Second_rotateZ";
	rename -uid "8DCBBDD8-48F6-F72C-4BF6-80936A39D02A";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 0 10 0 16 0 20 0;
createNode animCurveTU -n "Second_visibility";
	rename -uid "7FE3EF67-4AE7-C56E-5911-13B5AE08867B";
	setAttr ".tan" 9;
	setAttr -s 4 ".ktv[0:3]"  1 1 10 1 16 1 20 1;
	setAttr -s 4 ".kot[0:3]"  5 5 5 5;
createNode animCurveTL -n "Second_translateX";
	rename -uid "2F213EBA-4D6D-6945-2680-FB811EFD2B00";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 -5.5511151231257741e-017 10 0 16 0 20 0;
createNode animCurveTL -n "Second_translateY";
	rename -uid "B328DFC9-4D5C-EA42-C7DF-9684C511DA8B";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 0.88146573061746969 10 -1.8358392694797729
		 16 0.03611252442137558 20 1.0529752272812591;
createNode animCurveTL -n "Second_translateZ";
	rename -uid "CE64FB6B-40A9-462B-6476-C0BB2688B5DF";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 -0.93402753669443761 10 0 16 -0.58160908710172776
		 20 -0.89754488750266637;
createNode animCurveTU -n "Second_scaleX";
	rename -uid "423A18F6-488B-374C-7F99-39856643A3BF";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 1 10 1 16 2.2634467246681296 20 1;
createNode animCurveTU -n "Second_scaleY";
	rename -uid "5897823D-4181-173A-37A9-5E90050E9B73";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 1 10 1 16 2.2634467246681296 20 1;
createNode animCurveTU -n "Second_scaleZ";
	rename -uid "3610D247-4829-4863-880D-7FAD6AD04A9F";
	setAttr ".tan" 18;
	setAttr -s 4 ".ktv[0:3]"  1 1 10 1 16 2.2634467246681296 20 1;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "84AF78A1-4361-DA85-036C-F68D124E3398";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 20 -ast 1 -aet 20 ";
	setAttr ".st" 6;
createNode reference -n "gpuRN";
	rename -uid "77E2EA3C-4975-3FF7-BA0A-37A319DC4069";
	setAttr -s 10 ".phl";
	setAttr ".phl[1]" 0;
	setAttr ".phl[2]" 0;
	setAttr ".phl[3]" 0;
	setAttr ".phl[4]" 0;
	setAttr ".phl[5]" 0;
	setAttr ".phl[6]" 0;
	setAttr ".phl[7]" 0;
	setAttr ".phl[8]" 0;
	setAttr ".phl[9]" 0;
	setAttr ".phl[10]" 0;
	setAttr ".ed" -type "dataReferenceEdits" 
		"gpuRN"
		"gpuRN" 0
		"gpuRN" 33
		0 "|gpu:Main|gpu:MainShape" "|Main" "-s -r -add "
		0 "|gpu:Main|gpu:MainShape" "|Main1" "-s -r -add "
		0 "|gpu:Main|gpu:MainShape" "|Main2" "-s -r -add "
		0 "|gpu:Main|gpu:MainShape" "|Main3" "-s -r -add "
		0 "|gpu:Main|gpu:testGpuCache|gpu:testGpuCacheShape" "|Main|testGpuCache" 
		"-s -r -add "
		0 "|gpu:Main|gpu:testGpuCache|gpu:testGpuCacheShape" "|Main1|testGpuCache1" 
		"-s -r -add "
		0 "|gpu:Main|gpu:testGpuCache|gpu:testGpuCacheShape" "|Main2|testGpuCache2" 
		"-s -r -add "
		0 "|gpu:Main|gpu:testGpuCache|gpu:testGpuCacheShape" "|Main3|testGpuCache3" 
		"-s -r -add "
		2 "|gpu:Main" "translate" " -type \"double3\" -3.4092447196712508 -0.28566508827778092 -1.1717693398823246"
		
		2 "|gpu:Main" "translateX" " -av"
		2 "|gpu:Main" "translateY" " -av"
		2 "|gpu:Main" "translateZ" " -av"
		2 "|gpu:Main" "rotate" " -type \"double3\" -16.859943209786703 1.4944960254475526 0.81331991850054297"
		
		2 "|gpu:Main" "rotateX" " -av"
		2 "|gpu:Main" "rotateY" " -av"
		2 "|gpu:Main" "rotateZ" " -av"
		2 "|gpu:Main" "scale" " -type \"double3\" 0.78263264157965207 0.60381268982037684 0.78263264157965207"
		
		2 "|gpu:Main" "scaleX" " -av"
		2 "|gpu:Main" "scaleY" " -av"
		2 "|gpu:Main" "scaleZ" " -av"
		2 "|gpu:Main|gpu:MainShape" "selectionChildHighlighting" " 1"
		2 "|gpu:Main|gpu:MainShape" "dispGeometry" " 1"
		2 "|gpu:Main|gpu:testGpuCache|gpu:testGpuCacheShape" "selectionChildHighlighting" 
		" 1"
		5 4 "gpuRN" "|gpu:Main.translateX" "gpuRN.placeHolderList[1]" ""
		5 4 "gpuRN" "|gpu:Main.translateY" "gpuRN.placeHolderList[2]" ""
		5 4 "gpuRN" "|gpu:Main.translateZ" "gpuRN.placeHolderList[3]" ""
		5 4 "gpuRN" "|gpu:Main.rotateX" "gpuRN.placeHolderList[4]" ""
		5 4 "gpuRN" "|gpu:Main.rotateY" "gpuRN.placeHolderList[5]" ""
		5 4 "gpuRN" "|gpu:Main.rotateZ" "gpuRN.placeHolderList[6]" ""
		5 4 "gpuRN" "|gpu:Main.scaleX" "gpuRN.placeHolderList[7]" ""
		5 4 "gpuRN" "|gpu:Main.scaleY" "gpuRN.placeHolderList[8]" ""
		5 4 "gpuRN" "|gpu:Main.scaleZ" "gpuRN.placeHolderList[9]" ""
		5 4 "gpuRN" "|gpu:Main.visibility" "gpuRN.placeHolderList[10]" "";
	setAttr ".ptag" -type "string" "";
lockNode -l 1 ;
createNode animCurveTL -n "Main_translateX1";
	rename -uid "51D4FE12-4789-B517-AA1B-22B5786F8563";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 11 -3.18239060814861 20 -3.5047622403123628;
createNode animCurveTL -n "Main_translateY1";
	rename -uid "0A3C98DB-48F9-432B-3470-0C9C4E891742";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 11 -0.18157914225744548 20 -0.45885275874954029;
createNode animCurveTL -n "Main_translateZ1";
	rename -uid "51B7D902-4CFF-8B4B-039E-519D45FF69D2";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 11 -0.47007634107560614 20 -2.4999329097686509;
createNode animCurveTU -n "Main_visibility1";
	rename -uid "4A3DB525-4B1C-DAD2-302E-00B0154AA936";
	setAttr ".tan" 9;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 1 20 1;
	setAttr -s 3 ".kot[0:2]"  5 5 5;
createNode animCurveTA -n "Main_rotateX1";
	rename -uid "A7A76C4A-4A3C-A1F0-868D-75A11FF523B2";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 11 -20.533459369798884 20 -6.3641827526090538;
createNode animCurveTA -n "Main_rotateY1";
	rename -uid "8DB155B8-4AAF-C703-C5C2-D4AD2A305528";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 11 -5.054679637795755 20 20.206426491856988;
createNode animCurveTA -n "Main_rotateZ1";
	rename -uid "A529FF2C-4265-2AD0-1FA5-F39042BC8C7F";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 0 11 -13.237171145063527 20 40.957580100112146;
createNode animCurveTU -n "Main_scaleX1";
	rename -uid "3D14B6B0-42A0-A288-D537-41BD6C10AC06";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 0.78263264157965207 20 0.78263264157965207;
createNode animCurveTU -n "Main_scaleY1";
	rename -uid "C04E9175-407D-218F-61F3-ABBBD03CA1E0";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 0.78263264157965207 20 0.28612725489695612;
createNode animCurveTU -n "Main_scaleZ1";
	rename -uid "73C0FB28-4BD3-190D-9EAD-3EBE8FD36F45";
	setAttr ".tan" 18;
	setAttr -s 3 ".ktv[0:2]"  1 1 11 0.78263264157965207 20 0.78263264157965207;
select -ne :time1;
	setAttr ".o" 14;
	setAttr ".unw" 14;
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
	setAttr -s 4 ".r";
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
connectAttr "Main_translateX.o" "rigRN.phl[1]";
connectAttr "Main_translateY.o" "rigRN.phl[2]";
connectAttr "Main_translateZ.o" "rigRN.phl[3]";
connectAttr "Main_rotateX.o" "rigRN.phl[4]";
connectAttr "Main_rotateY.o" "rigRN.phl[5]";
connectAttr "Main_rotateZ.o" "rigRN.phl[6]";
connectAttr "Main_scaleX.o" "rigRN.phl[7]";
connectAttr "Main_scaleY.o" "rigRN.phl[8]";
connectAttr "Main_scaleZ.o" "rigRN.phl[9]";
connectAttr "Main_visibility.o" "rigRN.phl[10]";
connectAttr "Second_translateX.o" "rigRN.phl[11]";
connectAttr "Second_translateY.o" "rigRN.phl[12]";
connectAttr "Second_translateZ.o" "rigRN.phl[13]";
connectAttr "Second_rotateX.o" "rigRN.phl[14]";
connectAttr "Second_rotateY.o" "rigRN.phl[15]";
connectAttr "Second_rotateZ.o" "rigRN.phl[16]";
connectAttr "Second_scaleX.o" "rigRN.phl[17]";
connectAttr "Second_scaleY.o" "rigRN.phl[18]";
connectAttr "Second_scaleZ.o" "rigRN.phl[19]";
connectAttr "Second_visibility.o" "rigRN.phl[20]";
connectAttr "Main_translateX1.o" "gpuRN.phl[1]";
connectAttr "Main_translateY1.o" "gpuRN.phl[2]";
connectAttr "Main_translateZ1.o" "gpuRN.phl[3]";
connectAttr "Main_rotateX1.o" "gpuRN.phl[4]";
connectAttr "Main_rotateY1.o" "gpuRN.phl[5]";
connectAttr "Main_rotateZ1.o" "gpuRN.phl[6]";
connectAttr "Main_scaleX1.o" "gpuRN.phl[7]";
connectAttr "Main_scaleY1.o" "gpuRN.phl[8]";
connectAttr "Main_scaleZ1.o" "gpuRN.phl[9]";
connectAttr "Main_visibility1.o" "gpuRN.phl[10]";
connectAttr "testCamera_translateX.o" "testCamera.tx";
connectAttr "testCamera_translateY.o" "testCamera.ty";
connectAttr "testCamera_translateZ.o" "testCamera.tz";
connectAttr "testCamera_visibility.o" "testCamera.v";
connectAttr "testCamera_rotateX.o" "testCamera.rx";
connectAttr "testCamera_rotateY.o" "testCamera.ry";
connectAttr "testCamera_rotateZ.o" "testCamera.rz";
connectAttr "testCamera_scaleX.o" "testCamera.sx";
connectAttr "testCamera_scaleY.o" "testCamera.sy";
connectAttr "testCamera_scaleZ.o" "testCamera.sz";
connectAttr "expression1.out[0]" "testCameraShape.hs";
connectAttr "expression2.out[0]" "testCameraShape.vs";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr ":time1.o" "expression1.tim";
connectAttr "testCameraShape.msg" "expression1.obm";
connectAttr ":time1.o" "expression2.tim";
connectAttr "testCameraShape.msg" "expression2.obm";
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "pPlaneShape1.iog" ":initialShadingGroup.dsm" -na;
// End of testAnimation.ma
