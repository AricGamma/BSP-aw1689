@echo off

echo Creating Images for all products under Products
dir /b /AD %SRC_DIR%\Products\*.* > %BSP_ARCH%products.txt

for /f "delims=" %%i in (%BSP_ARCH%products.txt) do (
  echo ----------Creating %%i Test Image-------------
  call createimage.cmd %%i Test
  echo ----------Creating %%i Retail Image-----------
  call createimage.cmd %%i Retail
)

del %BSP_ARCH%products.txt
