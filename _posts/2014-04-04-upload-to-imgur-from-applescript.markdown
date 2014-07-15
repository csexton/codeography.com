---
layout: post
title: Upload to imgur from applescript
---

A little scrip

```applescript
on run {input, parameters}
  tell application "Finder"
    -- convert file paths to posix
    set imageList to {}
    set linkList to {}
    repeat with i from 1 to (count input)
      set end of imageList to POSIX path of (item i of input as alias)
      set file_name to name of (item i of input as alias)
    end repeat

    -- no images selected
    if (count imageList) is 0 then
      display dialog "No image files selected" with title "Imgur uploader" buttons {"Quit"} default button "Quit"
      return

    --upload
    else
      display notification "Preparing to upload " & (count imageList) & " images" with title "Uploaded Started"

      repeat with i from 1 to (count imageList)
        set apiKey to "26ff5c40cbedf50e7f81124ab473c1cc"
        set curlCommand to "curl -F \"key=" & apiKey & "\" -F \"image=@" & item i of imageList & "\" http://api.imgur.com/2/upload"
        set answer to do shell script curlCommand
        set atid to AppleScript's text item delimiters
        set AppleScript's text item delimiters to "<original>"
        set link to text item 2 of answer
        set AppleScript's text item delimiters to "<"
        set link to text item 1 of link
        set AppleScript's text item delimiters to atid
        set end of linkList to link
      end repeat
    end if
  end tell

  set links to joinList(linkList, " ")
  set the clipboard to links

  display notification "Successfully Uploaded Screenshot and Copied the URL to the Clipboard" with title "Uploaded Finished" sound name "Purr"

end run

to joinList(aList, delimiter)
  set retVal to ""
  set prevDelimiter to AppleScript's text item delimiters
  set AppleScript's text item delimiters to delimiter
  set retVal to aList as string
  set AppleScript's text item delimiters to prevDelimiter
  return retVal
end joinList

```
