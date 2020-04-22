#!/usr/bin/env bash
echo "Good Morning Gamer, what event you need "
read eventCode
>results.txt
>nicknames.txt
curl -X GET "https://www.thebluealliance.com/api/v3/event/$eventCode/teams/simple" -H "accept: application/json" -H "X-TBA-Auth-Key: icVifn1ZDq7vWcwCVvW1tBtTGSVSaQWIRJAzp7O21tQPSBmfK509B8dbKhxyMAF9" | jq '.[]| .team_number' >> results.txt
curl -X GET "https://www.thebluealliance.com/api/v3/event/$eventCode/teams/simple" -H "accept: application/json" -H "X-TBA-Auth-Key: icVifn1ZDq7vWcwCVvW1tBtTGSVSaQWIRJAzp7O21tQPSBmfK509B8dbKhxyMAF9" | jq '.[]|.nickname' >> nicknames.txt
python sqlshit.py
echo "Pit Scout Info Input"
>redteams.txt
>blueteams.txt
>matchnumbers.txt
curl -X GET "https://www.thebluealliance.com/api/v3/event/$eventCode/matches/simple" -H "accept: application/json" -H "X-TBA-Auth_Key: XVf8ZR32K9P7m2RoH6Y4cirm020uw8F12pNrj5SLxXhGAFe7M1wtBRxNdu6AjbvU"| jq '.[]|select(.comp_level|contains("qm"))|.alliances|.red|.team_keys[]' >> redteams.txt
curl -X GET "https://www.thebluealliance.com/api/v3/event/$eventCode/matches/simple" -H "accept: application/json" -H "X-TBA-Auth_Key: XVf8ZR32K9P7m2RoH6Y4cirm020uw8F12pNrj5SLxXhGAFe7M1wtBRxNdu6AjbvU"| jq '.[]|select(.comp_level|contains("qm"))|.alliances|.blue|.team_keys[]' >> blueteams.txt
curl -X GET "https://www.thebluealliance.com/api/v3/event/$eventCode/matches/simple" -H "accept: application/json" -H "X-TBA-Auth_Key: XVf8ZR32K9P7m2RoH6Y4cirm020uw8F12pNrj5SLxXhGAFe7M1wtBRxNdu6AjbvU"| jq '.[]|select(.comp_level| contains("qm"))|.match_number' >> matchnumbers.txt
python scheduleInsert.py
echo "Schedule Info Input"
