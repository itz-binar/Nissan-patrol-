@echo off
setlocal enabledelayedexpansion

:: Set the mods directory path (adjust if needed)
set "mods_dir=D:\T50-4\LXCheHuoMoNiQi0.34\BeamNG.drive\0.34\mods"

:: List of non-car files to delete
set "non_car_files=(
chipvolumetricclouds_0.53b_modland.zip
Command Prompt.lnk
db.json
dr1azlodikan.zip
e190_modland.zip
enhancedorbit.zip
enhanced_chase_camera.zip
ep2k_modland.zip
F-22A.zip
gepi_sr_modland.zip
J35D-gripen.zip
me262.zip
messerschmitt-me262.zip
translations.zip
USSRProject_Railway_modland.zip
)"

:: Delete each non-car file
echo Deleting non-car files...
for %%f in (%non_car_files%) do (
    if exist "%mods_dir%\%%f" (
        del "%mods_dir%\%%f"
        echo Deleted: %%f
    )
)

echo.
echo Cleanup complete!
pause
