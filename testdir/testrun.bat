@echo off
rem
rem Run one test.
rem


awk --version
echo | set /p dummy="Running test %~n1... "
maketest %1

rem Get start time:
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "start=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

awk -f %~n1.awk %~n1.in >%~n1.out

rem Get end time:
for /F "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "end=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)*100+1%%d %% 100"
)

rem Get elapsed time:
set /A elapsed=end-start


fc /A %~n1.ref %~n1.out >NUL
if errorlevel 1 (
  echo failed
  fc /A %~n1.ref %~n1.out
) else (
  del %~n1.awk %~n1.in %~n1.ref %~n1.out
  echo ok elapsed=%elapsed%
)

