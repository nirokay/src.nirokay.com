// Local vars:
let leaderboardInitFailed = false;
let leaderboardGameName: string = "";
let leaderboardGameVersion: string = "";

// HTML stuff:
const idLeaderboardsDiv: string = "id-init-leaderboard";
const idLeaderboardsUsernameDiv: string = "id-leaderboard-username-div";
const idLeaderboardsUsername: string = "id-leaderboard-username";
const idLeaderboardTable: string = "id-leaderboard-table";
const idLeaderboardsStatusDiv: string = "id-leaderboard-status-div";
const idLeaderboardsStatus: string = "id-leaderboard-status";

function getLeaderboardTableContentFrom(json: string): string {
    let result: string[] = [
        "<thead>",
        "<th>Username</th>",
        "<th>Score</th>",
        "<th>Version</th>",
        "</thead>",
        "<tbody>",
    ];
    try {
        // Parse JSON:
        let data = JSON.parse(json) as {
            code: number;
            message: string;
            data: {
                timestamp: number;
                name: string;
                score: number;
                version: string;
            }[];
        };

        // Fill up empty places:
        while (data.data.length != 10)
            data.data.push({ timestamp: 0, name: "", score: 0, version: "" });

        // Generate HTML:
        data.data.forEach((entry, index) => {
            let lines: string[] = [];
            function td(text: string) {
                lines.push("<td>" + text + "</td>");
            }
            lines.push("<tr>");
            let name: string = "";
            if (name.length <= 16) {
                name = entry.name;
            } else {
                name = entry.name.slice(0, 16) + "...";
            }

            td("<b>" + (index + 1) + ".</b> " + name);
            td(entry.score == 0 ? "" : entry.score.toString());
            td(entry.version);
            lines.push("</tr>");
            result.push(lines.join("")); // reduces elements in result
        });
    } catch (e) {
        console.error("Failed to construct leaderboard content", e);
        result.push("ERROR");
        leaderboardInitFailed = true;
    }
    result.push("</tbody>");
    return result.join("");
}

function injectLeaderboardTable(): boolean {
    let div: HTMLElement | null = document.getElementById(idLeaderboardsDiv);
    if (div == null) return false;

    div.innerHTML =
        `<div id="` +
        idLeaderboardsUsernameDiv +
        `">
        <label for = "` +
        idLeaderboardsUsername +
        `">Username:</label>
        <input type="text" name="` +
        idLeaderboardsUsername +
        `" id="` +
        idLeaderboardsUsername +
        `"></input>
        </div>` +
        `<table id="` +
        idLeaderboardTable +
        `">` +
        getLeaderboardTableContentFrom(
            '{"code":200, "message":"Leaderboards initialized.", "data":[]}',
        ) +
        `</table>
        <div id="` +
        idLeaderboardsStatusDiv +
        `">
        <small id="` +
        idLeaderboardsStatus +
        `">Leaderboards initialized.</small>
        </div>
    `;

    return true;
}

function setLeaderboardStatusMessage(text: string) {
    let element: HTMLElement | null =
        document.getElementById(idLeaderboardsStatus);
    if (element == null) {
        console.error("Failed to find status message element.");
        return;
    }
    let now: Date = new Date();
    let time: string = now.toISOString();
    element.innerHTML = text + " @ " + "<small>" + time + "</small>";
}

function injectLeaderboardData(json: string) {
    let html: string = getLeaderboardTableContentFrom(json);
    let table: HTMLElement | null = document.getElementById(idLeaderboardTable);
    if (table == null) {
        console.error("Could not find leaderboard table.");
        return;
    }
    table.innerHTML = html;
}
function injectLeaderboardDataJson(json: JSON) {
    injectLeaderboardData(JSON.stringify(json));
}

function initLeaderboard(gameName: string, version: string) {
    leaderboardGameName = gameName;
    leaderboardGameVersion = version;

    if (!injectLeaderboardTable()) leaderboardInitFailed = true;
    leaderboardsGetRequest();
}

function getLeaderboardUsername(): string {
    let element: HTMLInputElement | null = document.getElementById(
        idLeaderboardsUsername,
    ) as HTMLInputElement;
    if (element == null) {
        console.error("Could not find username input.");
        return "";
    }
    return element.value;
}

// URL stuff:
const leaderboardsBaseUrl: string = "https://leaderboards.nirokay.com/";
const leaderboardStatusUrl: string = leaderboardsBaseUrl + "status";
const leaderboardsBaseGameUrl: string = leaderboardsBaseUrl + "leaderboard/";

function getLeaderboardPostUrl(): string {
    return leaderboardsBaseUrl;
}

function getLeaderboardGetUrl(): string {
    return leaderboardsBaseGameUrl + leaderboardGameName;
}

async function leaderboardsGetRequest() {
    try {
        let request = await fetch(getLeaderboardGetUrl());
        let json: JSON = await request.json();
        injectLeaderboardDataJson(json);
        setLeaderboardStatusMessage("Successfully fetched data.");
    } catch (e) {
        console.error("Failed to fetch leaderboard", e);
        setLeaderboardStatusMessage("Failed to fetch leaderboard data.");
    }
}

async function leaderboardsPostRequest(score: number) {
    if (score == 0) {
        console.log("Leaderboard post request rejected, score is 0.");
        return;
    }
    let data = {
        name: encodeURI(getLeaderboardUsername()),
        score: score,
        game: encodeURI(leaderboardGameName),
        version: encodeURI(leaderboardGameVersion),
    };

    let headers: Headers = new Headers();
    headers.set("Content-Type", "application/json");
    headers.set("Accept", "application/json");

    let request: RequestInfo = new Request(getLeaderboardPostUrl(), {
        method: "POST",
        headers: headers,
        body: JSON.stringify(data),
    });

    console.log("Sending...");
    try {
        await fetch(request)
            .then((response) => {
                console.log("Response:", response);
                setLeaderboardStatusMessage("Successfully sent data.");
            })
            .then(() => {
                console.log("Updating leaderboard.");
                leaderboardsGetRequest();
            });
    } catch (e) {
        console.error("Failed to send/update after send.", e);
    }
    console.log("Finished");
}
