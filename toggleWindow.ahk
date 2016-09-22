; Launch or toggle program, http://lifehacker.com/5468862/create-a-shortcut-key-for-restoring-a-specific-window
; -----------------------------------------------------------------------------
ActivateWinByTitle(WindowTitle)
{
    SetTitleMatchMode,2
    DetectHiddenWindows, Off
    /*
    IfWinActive, %WindowTitle%
    WinMinimize, %WindowTitle%
    Else
    */
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
    ActivateWinByTitle(winTitle)
}

ActivateWinByTitleById(ID)
{
    WinActivate, ahk_id %ID%
}

RegisterWindow(bindKey) {
    WinGet, WinId, ID, A
    MsgBox, %WinId% will be bind to %bindKey%
    key = %bindKey%
    callback := Func("ActivateWinByTitleById").bind(WinId)
    Hotkey, % key, % callback, On
}

AskForKeyBindAndRegWin(bindKey) {
    WinGet, WinId, ID, A
    InputBox, key, ,"Enter the key you want to bind with %bindKey% to activate %WinId%"
    finalKey = %bindKey% & %key%
    callback := Func("ActivateWinByTitleById").bind(WinId)
    Hotkey, % finalKey, % callback, On
    MsgBox, "Bindinded %finalKey% to %WinId%"
}

/*
<!h::ActivateWinByTitle("hadoop-main")
<!s::ActivateWinByTitle("spark-parent")
<!e::ActivateWinByTitle("Microsoft Edge")
<!c::ActivateWinByTitle("ConsoleZ")
<!m::RunOrActivateOrMinimizeProgram("mintty.exe")
<!a::ActiveWinTitleFromInput()

#^1::RegisterWindow("#+1")
#^2::RegisterWindow("#+2")
#^3::RegisterWindow("#+3")
#^4::RegisterWindow("#+4")
#^5::RegisterWindow("#+5")

^+1::RegisterWindow("Capslock & 1")
^+2::RegisterWindow("Capslock & 2")
^+3::RegisterWindow("Capslock & 3")
^+4::RegisterWindow("Capslock & 4")
^+5::RegisterWindow("Capslock & 5")
^+6::RegisterWindow("Capslock & 6")
^+7::RegisterWindow("Capslock & 7")
^+8::RegisterWindow("Capslock & 8")
^+9::RegisterWindow("Capslock & 9")
^+m::AskForKeyBindAndRegWin("Capslock")

#+1::RegisterWindow("Alt & 1")
#+2::RegisterWindow("Alt & 2")
#+3::RegisterWindow("Alt & 3")
#+4::RegisterWindow("Alt & 4")
#+5::RegisterWindow("Alt & 5")
#+6::RegisterWindow("Alt & 6")
#+7::RegisterWindow("Alt & 7")
#+8::RegisterWindow("Alt & 8")
#+9::RegisterWindow("Alt & 9")
*/
#+m::AskForKeyBindAndRegWin("Alt")
