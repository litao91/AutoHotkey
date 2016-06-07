; Variables definition
; -----------------------------------------------------------------------------
EnvGet, userProfile, USERPROFILE
Software := userProfile . "\Dropbox\software\"

; Launch or toggle program, http://lifehacker.com/5468862/create-a-shortcut-key-for-restoring-a-specific-window
; -----------------------------------------------------------------------------
ToggleWinMinimize(WindowTitle)
{
    SetTitleMatchMode,2
    DetectHiddenWindows, Off
    IfWinActive, %WindowTitle%
    WinMinimize, %WindowTitle%
    Else
    IfWinExist, %WindowTitle%
    {
        WinActivate
    }
    Return
}


RunOrActivateOrMinimizeProgram(Program, WorkingDir="", WindowSize="")
{
    SplitPath Program, ExeFile
    Process, Exist, %ExeFile%
    PID = %ErrorLevel%
    if (PID = 0)
    {
        Run, %Program%, %WorkingDir%, %WindowSize%
    }
    else
    {
        SetTitleMatchMode,2
        DetectHiddenWindows, Off
        IfWinActive, ahk_pid %PID%
        WinMinimize, ahk_pid %PID%
        Else
        IfWinExist, ahk_pid %PID%
        WinActivate, ahk_pid %PID%
        Return
    }
}

ActiveWinTitleFromInput()
{
    InputBox, winTitle
    ToggleWinMinimize(winTitle)
}

<!h::ToggleWinMinimize("hadoop-main")
<!s::ToggleWinMinimize("spark-parent")
<!e::ToggleWinMinimize("Microsoft Edge")
<!c::ToggleWinMinimize("ConsoleZ")
<!m::RunOrActivateOrMinimizeProgram("mintty.exe")
<!a::ActiveWinTitleFromInput()
