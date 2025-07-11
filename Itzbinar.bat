@echo off
setlocal enabledelayedexpansion
title BeamNG.drive Mod Manager v2.0
color 0A

:: ========================================
:: BeamNG.drive Mod Manager v2.0
:: Enhanced with full error handling and logging
:: ========================================

:: Configuration
set "LOG_FILE=%~dp0mod_transfer_log.txt"
set "BACKUP_ENABLED=1"
set "VERIFY_TRANSFERS=1"

:: Initialize log file
echo ========================================= > "%LOG_FILE%"
echo BeamNG.drive Mod Transfer Log >> "%LOG_FILE%"
echo Date: %date% %time% >> "%LOG_FILE%"
echo ========================================= >> "%LOG_FILE%"

:: Source and Destination paths
set "source=D:\T50-4\LXCheHuoMoNiQi0.34\BeamNG.drive\0.34\mods"
set "destination=C:\Users\%USERNAME%\AppData\Local\BeamNG.drive\0.34\mods"

:: Alternative destination paths (auto-detect)
if not exist "%destination%" (
    set "destination=C:\Users\Administrator\AppData\Local\BeamNG.drive\0.34\mods"
)
if not exist "%destination%" (
    set "destination=%LOCALAPPDATA%\BeamNG.drive\0.34\mods"
)

echo ========================================
echo  BeamNG.drive Mod Manager v2.0
echo ========================================
echo.
echo Source: %source%
echo Destination: %destination%
echo.

:: Check if source directory exists
if not exist "%source%" (
    echo [ERROR] Source directory not found!
    echo Source: %source%
    echo.
    echo Please check if:
    echo 1. BeamNG.drive is installed in the correct location
    echo 2. The path is correct
    echo 3. You have proper permissions
    echo.
    echo [ERROR] Source directory not found: %source% >> "%LOG_FILE%"
    pause
    exit /b 1
)

:: Check if destination directory exists, create if not
if not exist "%destination%" (
    echo [INFO] Destination directory not found. Creating...
    mkdir "%destination%" 2>nul
    if not exist "%destination%" (
        echo [ERROR] Cannot create destination directory!
        echo Please run as administrator or check permissions.
        echo.
        echo [ERROR] Cannot create destination: %destination% >> "%LOG_FILE%"
        pause
        exit /b 1
    )
    echo [SUCCESS] Destination directory created.
    echo [INFO] Created destination directory: %destination% >> "%LOG_FILE%"
)

:: Create backup directory if enabled
if "%BACKUP_ENABLED%"=="1" (
    set "backup_dir=%~dp0backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    set "backup_dir=!backup_dir: =0!"
    set "backup_dir=!backup_dir::=!"
    mkdir "!backup_dir!" 2>nul
    echo [INFO] Backup directory: !backup_dir!
    echo [INFO] Backup directory created: !backup_dir! >> "%LOG_FILE%"
)

:: Enhanced file list with proper escaping
set "file_list=(
"2019款凯迪拉克CT5.zip"
"2022款丰田普拉多.zip"
"2023款本田雅阁.zip"
"2024 Ford Mustang(福特野马MK7 S650).zip"
"2024款大众Teramont Atlas Cross.zip"
"2024款特斯拉Model 3.zip"
"24model3xnme(特斯拉Model 3焕新版).zip"
"24特斯拉Model3_fix.zip"
"4代EVO.zip"
"911.zip"
"A4B9.5(奥迪A4旅行版B9.5).zip"
"a8d4.zip"
"acm_aurus_senat(俄罗斯总统车).zip"
"ACM_travel(拉达尼瓦Travel).zip"
"agera(科尼赛格Agera车系).zip"
"alc_fuso(三菱扶桑Canter 515轻卡).zip"
"Alfa Romeo 8C(阿尔法·罗密欧 8C Competizione).zip"
"alfstelvke(阿尔法罗密欧stelvio quadrifoglio).zip"
"AMGONE_V1_PHAIEN(奔驰AMG ONE超跑).zip"
"arf8(法拉利f8).zip"
"arfgt(福特GT 第一代).zip"
"Aries_Camaro(雪佛兰科迈罗).zip"
"arnavi(林肯领航员).zip"
"astonmartinke(阿斯顿·马丁V8&V12 Vantage S).zip"
"Audi A6 07 3.0.zip"
"AUDI RS6 C8 Rework.zip"
"audi-tt-2018-2023_1710049142_653776.zip"
"audia4b9keV2(奥迪A4 B9 V2).zip"
"audirs6pack(奥迪A6&RS6旅行版).zip"
"audis3(奥迪A3&S3 8V).zip"
"audi_a3(奥迪A3轿车 8V).zip"
"audi_a6rs6.zip"
"audi_a6_10-13(奥迪A6 C8).zip"
"audi_a6_andronisk_v11(奥迪A6 C8).zip"
"Audi_A7_4K8_xNME_V1.4_modfan.zip"
"Audi_A8_V10_RELEASE.zip"
"audi_Q7(奥迪Q7 4M).zip"
"audi_rs3.zip"
"Audi_RS6_Puplic_Fix.zip"
"avalon22byfahadandturki(丰田亚洲龙 XX50).zip"
"bailey_5th_gen_camaro(雪佛兰科迈罗 第五代).zip"
"bbmodsbentleyfs19(宾利飞驰 第三代).zip"
"BBMX222(奔驰迈巴赫S级 X222).zip"
"bcnz_contrail_v011.zip"
"BMW 7-Series (G12).zip"
"BMW G70 2024 1.0.1(宝马7系 760i xDrive G70).zip"
"BMW M5 2024(宝马i5轿车电改油 G60).zip"
"BMW M5 G90(宝马M5 G90).zip"
"BMWE34_mat_V30(宝马5系 E34).zip"
"BMWG82G83xNME(宝马M4 G82&G83).zip"
"Bmw_G20_MM(宝马3系 G20).zip"
"BMW_G30(宝马5系 G30).zip"
"BMW_M4_Flanje(宝马M4 F82).zip"
"BMW_X5M_Facelift.zip"
"bngtunerhilux(丰田海拉克斯AN30).zip"
"bngtunerjimny(铃木吉姆尼 JB74).zip"
"Bugatti Bolide.zip"
"bugatti_chiron(布加迪chiron v1.36).zip"
"c63coupekefix(奔驰C级轿跑车).zip"
"C63S Pack UNZIP.rar"
"C7ZR1_Ezo(雪佛兰克尔维特C7).zip"
"Camry Hybrid 2023(丰田凯美瑞双擎 XV70).zip"
"civic24_spadie(本田思域掀背版 FL).zip"
"coolray bng private(吉利缤越&BelGee X50).zip"
"cross24_spadie(丰田卡罗拉锐放).zip"
"cx90_spadie(马自达CX-90).zip"
"DBSxNMEv1.1(阿斯顿马丁DBS).zip"
"eqs2022(奔驰EQS).zip"
"evoxke(三菱EVO X).zip"
"F-22A.zip"
"f150KE(福特F150-修复版).zip"
"F296_frix(法拉利296GTB).zip"
"ferrari812KE(法拉利F12&812).zip"
"ferrariromaKE(法拉利罗马).zip"
"Ferrari_Portofino(法拉利Portofino).zip"
"Ford Focus ST 2022_V1.3_MMODS(福特福克斯ST C519 V1.3).zip"
"Ford Mustang S550-650(福特野马GT3&GTD&RTR&警车).zip"
"Ford_taurus_23(福特中东版金牛座&蒙迪欧).zip"
"G-Class_MODDED_By_ARMORED_LAB_modland.zip"
"Gallardo(兰博基尼Gallardo v2).zip"
"granbird(起亚Granbird巴士).zip"
"gt63_coupe_v1.1(奔驰AMG GT63 C192).zip"
"gwagonRR(奔驰G63 AMG).zip"
"h5ke(红旗h5 优化版).zip"
"highlander25_spadie(丰田大汉兰达 AS10).zip"
"hyundai accent 2024(现代雅绅特 bn7).zip"
"Hyundai Elantra(现代伊兰特 CN7).zip"
"Hyundai_Santa_Fe(现代胜达 DM).zip"
"inf812(法拉利812S&GTS&C&CA).zip"
"infhuracan(兰博基尼huracan).zip"
"inmq60(英菲尼迪Q60).zip"
"inmx7m60i(宝马X7 M60i G07).zip"
"inn_gavril_vertex(福特福克斯NA2 V3.6).zip"
"Jesko_Frix(柯尼塞格Jesko).zip"
"JSD_FADX6M(宝马X6M F96 改装版).zip"
"kers7pack(奥迪RS7 4G8).zip"
"KEx6f16(宝马X6 F16).zip"
"ke特斯拉Model S修复.zip"
"KE路虎揽胜.zip"
"Kia K8(起亚K8 GL3).zip"
"KWS(马自达6阿特兹).zip"
"lexusgsfKEV2(雷克萨斯GSF V2).zip"
"LX500(雷克萨斯LX500D).zip"
"LXRHondaAccord2023(本田雅阁第十一代).zip"
"m3g80-81_fix_bm(宝马M3 G80&81).zip"
"M5_F90.zip"
"macanKE(保时捷Macan Turbo).zip"
"man卡车_modland (1).zip"
"Maverick_R(CAM AM 独行侠R).zip"
"Mclaren_Artura_xNME(迈凯伦Artura).zip"
"mercedesw204ke(奔驰C63 AMG W204).zip"
"mercedes_benz_s_class_w222.zip"
"Mercedes_gt349V1_2(奔驰GT四门轿跑车 X290).zip"
"mestariq8(奥迪Q8系列).zip"
"MitsubishiTriton(三菱Triton皮卡).zip"
"Model X(特斯拉Model X).zip"
"Monjarabv(吉利星越L).zip"
"Nissan Altima(日产天籁 L34).zip"
"P1_Frix(迈凯伦P1).zip"
"paccatccv3.1(大众CC改款).zip"
"pacifica23(克莱斯勒大捷龙).zip"
"Pagani Huayra(帕加尼风神).zip"
"pajeroSport(三菱帕杰罗劲畅).zip"
"panamera970(保时捷帕拉梅拉 970).zip"
"Panamera_ezemods.zip"
"pininfarina_battista(宾利法利纳Battista).zip"
"Porsche 911 991V1.4(保时捷911 GT2&3).zip"
"Porsche 911 991V1.5(保时捷911 GT2&3).zip"
"Porsche 911 997.zip"
"PORSCHE_918.zip"
"q5_KE by hxmxnn(奥迪Q5更新).zip"
"raiiiu_tucson(现代途胜 NX4).zip"
"Range Rover(路虎揽胜2023).zip"
"regera_frix(柯尼塞格regera V1汉化).zip"
"renault_kangoo(雷诺 Kangoo货车).zip"
"Reventon_Frix(兰博基尼雷文顿).zip"
"rla_focus(福特福克斯RS MK3).zip"
"RR-Silverado(雪佛兰Silverado皮卡).zip"
"RR_2022_countach(兰博基尼countach LPi800).zip"
"RR_2024_Tacoma(丰田塔科马TRD Pro N400).zip"
"RR_aventador(兰博基尼aventador).zip"
"RR_F150(福特F150 P702).zip"
"RR_LaFerrari_v1.1(法拉利拉法).zip"
"RR_Tourbillon_v1.2(布加迪陀飞轮超跑).zip"
"RR_TRX(道奇RAM TRX).zip"
"rxxa8(奥迪A8 D3).zip"
"rxx_a8(奥迪A8 D3).zip"
"s60spiicy(沃尔沃S&V60 P3).zip"
"scirocco_fastlane(大众尚酷 V1.4).zip"
"sclasske(奔驰S级轿跑车 S217).zip"
"sentranismo(日产轩逸nismo).zip"
"sheik_mk7(大众高尔夫MK7.5).zip"
"sheik_polo6rV2(大众POLO 6R重置).zip"
"sheik_troc(大众T-Roc).zip"
"Simon_BMW_M2_F87(宝马M2 F87 LCI).zip"
"SL65BS(奔驰SL65 AMG Black Series R230).zip"
"sonataKE(现代索纳塔 ZN8).zip"
"Suzuki_Ignis(铃木ignis MF).zip"
"T4RunnerTRDPro(丰田超霸 2024最终版).zip"
"tiguan_andronisk_beta(第二代大众途观330TSI R-Line).zip"
"toyota crown 2023(丰田皇冠Sport Cross S235).zip"
"toyotaae86_dingos_hotfix2.zip"
"TTNAudiTTR(奥迪TT-R DTM).zip"
"TTNAztek(庞蒂亚克Aztek).zip"
"TTNChevroletMonza(雪佛兰科鲁泽 330T RS).zip"
"TTNFerrari599(法拉利599 GTB&O).zip"
"TTNRevuelto(兰博基尼Revuelto).zip"
"TTNSpeedtail(迈凯伦Speedtail).zip"
"TTNSurvolt(雪铁龙DS Survolt概念车).zip"
"UAZPatriotKDM.zip"
"Utopia_Frix(帕加尼Utopia).zip"
"Valkyrie_Frix(阿斯顿马丁Valkyrie).zip"
"veyronke(布加迪威龙).zip"
"VW-ID.3(大众id3).zip"
"vwID4ke(大众ID4).zip"
"VW_Arteon_BETA2(大众CC&Arteon 轿跑车&猎装车 B8).zip"
"VW_PASSAT_B8_BETA(大众进口帕萨特轿车&旅行车 B8).zip"
"w206keV2(奔驰C级 W206).zip"
"wentward_s3(美式校车巴士).zip"
"Wuling Sunshine S_modland.zip"
"x167keV2(奔驰GLS系列 X167).zip"
"xnme 400z v2(日产Z RZ34).zip"
"zonda_frix(帕加尼Zonda).zip"
"三菱Lancer Evolution X.zip"
"三菱帕杰罗.zip"
"丰田2024_Tacoma_v10.zip"
"丰田SUPRA.zip"
"丰田凯美瑞.zip"
"丰田埃尔法(中国车牌）.zip"
"丰田普拉多24款.zip"
"丰田超霸.zip"
"丰田陆地巡洋舰 200.zip"
"丰田陆巡(J80).zip"
"乐高小车.zip"
"五菱miniev 2Ali-Evo333作.zip"
"五菱宏光s 作者2Ali-Evo.zip"
"保时捷Macan EV.zip"
"兰博基尼大牛.zip"
"兰德酷路泽.zip"
"凯迪拉克ct4.zip"
"凯迪拉克xt6 0.28修复 2Ali-Evo333.zip"
"凯雷德.zip"
"劳斯莱斯Ghost_New_Update_modland.zip"
"劳斯莱斯古斯特 trix版.zip"
"劳斯莱斯魅影.zip"
"半人马座.zip"
"吉普牧马人JK四门版.zip"
"名爵.zip"
"哈弗猛龙.zip"
"塞纳.zip"
"大众捷达VA7.zip"
"大众迈腾B8.zip"
"大众途昂.zip"
"大众高尔夫8 GTIR（中国车牌）.zip"
"奇瑞瑞虎8.zip"
"奔驰CLS(C218)(1).zip"
"奔驰C级w206.zip"
"奔驰E63S.zip"
"奔驰G63GWagonRR.zip"
"奔驰GLE.zip"
"奔驰GLS.zip"
"奔驰G级车辆包(W463).zip"
"奔驰S级(W223) V3.zip"
"奔驰S级迈巴赫(Z223).zip"
"奔驰W223_NotJDsMods.zip"
"奔驰迈巴赫w223 皇冠作.zip"
"奥迪 RS7 2013款.zip"
"奥迪a7(4g8).zip"
"奥迪q5 修复.zip"
"奥迪RS e-tron GT v1.2.zip"
"奥迪rs5.zip"
"奥迪RS6_C8_Rework_modland.zip"
"奥迪RS7 ke作 群友更新3.2（包含开门模组以及中国车牌）.zip"
"奥迪RS7(4k8) v1.1 汉化版.zip"
"奥迪tt mk2(8J).zip"
"奥迪_A8_V11_RELEASE_PHAIEN.zip"
"奥迪_Q7.zip"
"安12运输机.zip"
"宝马5系.zip"
"宝马i4.zip"
"宝马M2.zip"
"宝马M4(F82) V0.29.zip"
"宝马X5.zip"
"宝马X7.zip"
"宾利添越_2Ali-Evo333 修复添加PBR灯光.zip"
"小型私人飞机.zip"
"小米su7.zip"
"布加迪Centodieci.zip"
"悍马EV电动版.zip"
"悍马H1 Alpha.zip"
"日产350Z改装版(Z33).zip"
"日产GTR.zip"
"本田crv24_spadie_FIXED_V1.0_modland.zip"
"本田雅阁十代 .zip"
"杜卡迪.zip"
"法拉利812.zip"
"法拉利PUROSANGUE(1).zip"
"法拉利purosangue.zip"
"法拉利SF90.zip"
"特斯拉Model 3 2024款.zip"
"特斯拉Model S.zip"
"特斯拉Model3.zip"
"特斯拉毛豆3.zip"
"特斯拉赛博皮卡.zip"
"现代胜达菲24款.zip"
"碰撞测试BIHS.zip"
"碰撞测试柱车.zip"
"福特Taurus.zip"
"红旗H3.zip"
"红旗h9.zip"
"路虎卫士 FiX修复.zip"
"路虎揽胜(L405) V1.1.zip"
"路虎揽胜星脉.zip"
"路虎揽胜运动版SVR.zip"
"迈凯伦塞纳.zip"
"铃木GSX-R 750.zip"
"长城坦克500.zip"
"雷克萨斯ES.zip"
"雷克萨斯LX570.zip"
"领克03(DY版).zip"
"马自达6.zip"
)"

echo Starting mod transfer process...
echo.

set "moved_count=0"
set "skipped_count=0"
set "error_count=0"
set "total_size=0"

:: Process each file in the list
for %%F in (%file_list%) do (
    set "current_file=%%~F"
    set "source_file=%source%\!current_file!"
    set "dest_file=%destination%\!current_file!"
    
    if exist "!source_file!" (
        :: Get file size
        for %%I in ("!source_file!") do set "file_size=%%~zI"
        
        :: Backup existing file if enabled
        if "%BACKUP_ENABLED%"=="1" (
            if exist "!dest_file!" (
                copy "!dest_file!" "!backup_dir!\!current_file!" >nul 2>&1
            )
        )
        
        :: Move file with verification
        echo [MOVING] !current_file!
        move "!source_file!" "!dest_file!" >nul 2>&1
        
        if exist "!dest_file!" (
            if "%VERIFY_TRANSFERS%"=="1" (
                :: Verify file size matches
                for %%I in ("!dest_file!") do (
                    if %%~zI neq !file_size! (
                        echo [WARNING] File size mismatch: !current_file!
                        echo [WARNING] File size mismatch: !current_file! >> "%LOG_FILE%"
                        set /a "error_count+=1"
                    )
                )
            )
            echo [SUCCESS] !current_file! - Size: !file_size! bytes
            echo [SUCCESS] !current_file! - Size: !file_size! bytes >> "%LOG_FILE%"
            set /a "moved_count+=1"
            set /a "total_size+=!file_size!"
        ) else (
            echo [ERROR] Failed to move: !current_file!
            echo [ERROR] Failed to move: !current_file! >> "%LOG_FILE%"
            set /a "error_count+=1"
        )
    ) else (
        echo [SKIPPED] !current_file! - File not found
        echo [SKIPPED] !current_file! - File not found >> "%LOG_FILE%"
        set /a "skipped_count+=1"
    )
)

:: Calculate total size in MB
set /a "total_size_mb=total_size/1024/1024"

echo.
echo ========================================
echo         TRANSFER COMPLETE
echo ========================================
echo Files Successfully Moved: %moved_count%
echo Files Skipped (Not Found): %skipped_count%
echo Files with Errors: %error_count%
echo Total Size Transferred: %total_size_mb% MB
echo.
echo Log file saved: %LOG_FILE%
if "%BACKUP_ENABLED%"=="1" (
    echo Backup directory: %backup_dir%
)
echo.

:: Final summary to log
echo ========================================= >> "%LOG_FILE%"
echo FINAL SUMMARY >> "%LOG_FILE%"
echo Files Successfully Moved: %moved_count% >> "%LOG_FILE%"
echo Files Skipped: %skipped_count% >> "%LOG_FILE%"
echo Files with Errors: %error_count% >> "%LOG_FILE%"
echo Total Size: %total_size_mb% MB >> "%LOG_FILE%"
echo End Time: %date% %time% >> "%LOG_FILE%"
echo ========================================= >> "%LOG_FILE%"

if %error_count% gtr 0 (
    color 0C
    echo [WARNING] Some files had errors during transfer!
    echo Please check the log file for details.
)

echo.
echo Press any key to exit...
pause >nul
exit /b 0
