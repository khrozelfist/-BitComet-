@echo off
setlocal enabledelayedexpansion
echo * ��Ѵ˽ű�������BitComet.exeͬĿ¼������ *
echo * ��Ǳ�Ҫ���������Թ���Ա������� *
echo * ������Ҫ�����б����ļ� *
echo.
echo ����BitComet�������İ湦������
echo �������г���������IP��ʾ����ͼ����¿���أ�������а�װ����
echo.
echo �˽ű����������²���
echo 1.�޸�BitComet*.exe�Ķ����ƴ��루ͬʱ֧��32λ/64λ��
echo 2.�滻���ԣ�����ѡ��Ϊ�������ģ�ʵ����ʾΪ��������
echo �޸ĵ��ļ���Bitcomet*.exe; BitComet.xml; /lang/bitcomet-zh_TW.mo
echo.
echo * �޸ĳ��������Ҫ��ʱ������ *
echo * �˽ű����谲װ��������� *
echo * �˽ű��������ظ����ж����¶�������� *
pause & cls
if EXIST C:\Windows\System32\Get-Content (
  del C:\Windows\System32\Get-Content
  if EXIST C:\Windows\System32\Get-Content (
    echo ���Թ���Ա����������д˽ű�
	pause & exit
  )
)
set l32=EB2883FE017518
set l64=EB2E83FF01751E
set b32=66B8041090900FB7F885F6750866B804109090
set b64=66B8041090900FB7D885FF750866B804109090
set cmd='dir /B /OGN bitcomet*.exe'
:START
echo ���������ļ����в���
cd /D "%~dp0"
dir /B /OGN bitcomet*.exe || (cls && ^
echo δ�ҵ�Bitcomet*.exe�����ű�����Ŀ¼������رձ����� && ^
echo �����Թ���Ա����޸��ļ���Ȩ�� && pause)
if %ERRORLEVEL% ==1 (icacls "%~dp0\" /grant administrators:F /T && goto START)
echo �������ڽ��룬���Ժ� ...
for /F %%a in (%cmd%) do (certutil -encodehex -f %%a %%a.hex 12)
if %ERRORLEVEL% ==0 echo ����ɹ� ��
for /F %%a in (%cmd%) do (
  set flag=0
  findstr /IC:%l32% %%a.hex >nul && set flag=1
  if !flag!==1 (findstr /IC:%b32% %%a.hex >nul && set flag=2)
  if !flag!==1 (
    echo �����޸�32λ���룬���Ժ� ...
    powershell.exe "(Get-Content %%a.hex) -replace '.{38}%l32%','%b32%%l32%' | Set-Content %%a.hex"
    echo 32λ�������ڱ��룬���Ժ� ...
    certutil -decodehex -f %%a.hex %%a
  ) else if !flag!==2 echo 32λ�����ѽ����������޸�
  findstr /IC:%l64% %%a.hex >nul && set flag=3
  if !flag!==3 (findstr /IC:%b64% %%a.hex >nul && set flag=4)
  if !flag!==3 (
    echo �����޸�64λ���룬���Ժ� ...
    powershell.exe "(Get-Content %%a.hex) -replace '.{38}%l64%','%b64%%l64%' | Set-Content %%a.hex"
    echo 64λ�������ڱ��룬���Ժ� ...
    certutil -decodehex -f %%a.hex %%a
  ) else if !flag!==4 echo 64λ�����ѽ����������޸�
)
if %ERRORLEVEL% ==0 echo �����޸���� ��
del *.hex
copy /Y .\lang\bitcomet-zh_CN.mo .\lang\bitcomet-zh_TW.mo && echo �޸������ļ��ɹ� ��
set axml="%APPDATA%\BitComet\BitComet.xml"
if EXIST BitComet.xml (
  powershell.exe "(Get-Content BitComet.xml) -replace '<Settings>','<Settings><Language>Chinese (Traditional, Taiwan)</Language>' | Set-Content BitComet.xml"
) else if EXIST %axml% (
  powershell.exe "(Get-Content %axml%) -replace '<Settings>','<Settings><Language>Chinese (Traditional, Taiwan)</Language>' | Set-Content %axml%"
) else (
  echo ^<BitComet^> >>BitComet.xml
  echo   ^<Settings^> >>BitComet.xml
  echo    ^<Language^>Chinese ^(Traditional, Taiwan^)^<^/Language^> >>BitComet.xml
  echo   ^</Settings^> >>BitComet.xml
  echo ^</BitComet^> >>BitComet.xml
)
if %ERRORLEVEL% ==0 echo �޸��������óɹ� ��
echo.
echo * ���в�������ɣ���ȷ����ʾ��Ϣ *
echo * ����ʾ���ܾ����ʡ������Թ���Ա������д˽ű� *
pause