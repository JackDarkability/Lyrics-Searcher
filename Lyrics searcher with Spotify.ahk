#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^+p::
WinGetTitle, spotify_playing, ahk_class Chrome_WidgetWin_0 ;Get the title of Spotify which contains the track-name

WinGet, id, list, ahk_exe  Spotify.exe
Loop, %id%
{
	this_ID := id%A_Index%
        WinGetTitle, title, ahk_id %this_ID%
        If (title = "")
        	continue
        If (title != "Spotify Premium")
        {
        	spotify_playing := title
                break
        }
}


spotify_array := StrSplit(spotify_playing,"-", A_Space)
NameOfArtist := spotify_array[1]
NameOfSong := spotify_array[2]


wb := ComObjCreate("InternetExplorer.Application")
;~ wb.Visible := true
ArtistReal := StrReplace(NameOfArtist, " ", "-")

SongReal := StrReplace(NameOfSong, " ", "-")

link := "https://www.musixmatch.com/es/letras/" . ArtistReal . "/" . SongReal

wb.Navigate(link)
while wb.Busy
    continue
Var := wb.document.body.innertext

FirstBit := wb.document.getElementsByTagName("P")[0].innertext
SecondBit := wb.document.getElementsByTagName("P")[1].innertext
wb.quit()


Finished := FirstBit . "`n" . SecondBit
clipboard := ""
Sleep, 200
clipboard := Finished
return

esc:
exitapp
return
