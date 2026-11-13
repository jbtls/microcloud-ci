# TechNova Micro-Cloud – Projektauftrag „Stack unter Versionskontrolle mit CI“

[![Microcloud-CI](../../actions/workflows/microcloud-ci.yml/badge.svg?branch=main)](../../actions/workflows/microcloud-ci.yml?query=branch%3Amain)

> [!IMPORTANT]
> **Starte hier: Öffne dein [Lern-Kanban-Board](https://jbtls.github.io/microcloud-ci/kanban/).**
> Das Board ist dein Arbeitsplan für die Woche: Jede Karte ist eine Aufgabe, mit Checkliste und Link zur passenden Anleitung. Daran siehst du jederzeit, wie weit du bist. [So arbeitest du damit](#dein-lern-kanban-board)

> **Lernfeld 10 – Serverdienste bereitstellen und Administrationsaufgaben automatisieren**
> Projektwoche KW47 · ca. 6–8 Unterrichtsstunden · Einzelarbeit, Austausch im Team ausdrücklich erwünscht

Das Abzeichen oben zeigt den Zustand deines Projekts auf `main`: **grau** = noch kein Lauf, **rot** (`failing`) = der automatische Test schlägt fehl, **grün** (`passing`) = alles in Ordnung.

- Direkt nach dem Erstellen deines Repos ist es **rot**: Dein Stack fehlt ja noch (Phase 2). Das ist normal.
- Das Abzeichen aktualisiert sich mit **bis zu 5 Minuten Verzögerung**, weil der Browser das Bild zwischenspeichert. Notfalls die Seite neu laden (Strg+F5). Den aktuellen Stand zeigt immer der Tab **Actions**.

---

## Ausgangssituation

In **Modul 4** hast du auf deinem LXC-Container in `~/microcloud` einen Compose-Stack gebaut: eine `compose.yml` mit einem nginx-Webserver und deine Statusseite `html/index.html`. Der Stack läuft – aber er existiert **nur auf deinem Container**. Wenn der Container kaputtgeht, ist alles weg, niemand sieht, was du wann geändert hast, und jede Änderung landet ungetestet direkt im Betrieb.

Die TechNova GmbH stellt deshalb um: **Jede Konfiguration liegt in einem Git-Repository auf GitHub** (Infrastructure as Code), und **jede Änderung wird automatisch getestet**, bevor sie in Betrieb geht. Für die Tests hat die IT-Leitung einen fertigen GitHub-Actions-Workflow vorgegeben: [`.github/workflows/microcloud-ci.yml`](.github/workflows/microcloud-ci.yml).

Zwei neue Vorgaben gelten ab sofort:

1. **Port 8085:** Die Microcloud-Webdienste werden im Firmennetz einheitlich über **Port 8085** veröffentlicht.
2. **Wechsel auf Apache:** Der Webserver soll mittelfristig von nginx auf **Apache httpd** umgestellt werden. Die Umstellung wird auf einem eigenen Entwicklungszweig vorbereitet und darf erst in den Hauptzweig `main`, wenn die automatischen Tests grün sind.

---

## Dein Lern-Kanban-Board

**👉 [jbtls.github.io/microcloud-ci/kanban/](https://jbtls.github.io/microcloud-ci/kanban/)**
Offline-Fassung: [`kanban/index.html`](kanban/index.html) in deinem eigenen Repo. Herunterladen und im Browser öffnen, sie funktioniert auch ohne Internet.

So arbeitest du damit:

| Spalte | Bedeutung |
|---|---|
| **Zu erledigen** | Hier liegen zu Beginn alle Aufgaben, sortiert nach Phasen. |
| **In Bearbeitung** | Daran arbeitest du gerade. Am besten immer nur **eine** Karte. |
| **Done** | Fertig, und alle Punkte der Checkliste sind abgehakt. |

- Ein Klick auf eine Karte öffnet die **Details**: Ziel, Checkliste, Links zu Anleitung und Hilfeseiten, geschätzte Zeit. Mit der Zeiterfassung kannst du festhalten, wie lange du gebraucht hast.
- Der Reiter **Zeitplan** zeigt die Woche als Balkendiagramm (Gantt) und welche Aufgabe auf welcher aufbaut.
- **Du hängst fest?** Lies zuerst [Typische Fehler und Lösungen](hilfe/typische-fehler.md), frage danach im Team und erst dann die Lehrkraft.

> [!WARNING]
> **Dein Fortschritt wird nur in diesem Browser gespeichert.** An Schul-PCs geht er beim Abmelden verloren, und deine Lehrkraft sieht dein Board nicht automatisch.
> Klicke deshalb am Ende jeder Stunde auf **Export** und speichere die Datei, z. B. als `kanban-fortschritt.json` in deinem Repo (committen und pushen). Beim nächsten Mal lädst du sie über **Import** wieder. Bei Rückfragen zeigst du dein Board auf dem Bildschirm.

---

## Wähle deinen Weg

Alle drei Wege führen zum selben Ergebnis (siehe *Definition of Done*). Du darfst jederzeit wechseln.

| Weg | Für wen? | Womit arbeitest du? |
|---|---|---|
| **Experte** | Du kennst Git schon und willst selbst knobeln. | Nur die [Kundenanforderungen](#expertenauftrag-nur-die-anforderungen) |
| **Standard** | Du willst klare Ziele pro Phase, findest den Weg aber selbst. | Die [Phasenübersicht](#standardauftrag-phasen-mit-zielen) unten + [Hilfeseiten](hilfe/) |
| **Basis** | Du möchtest jeden Schritt angeleitet. | Die [geführten Anleitungen](anleitung/) – Schritt für Schritt mit allen Befehlen |

Egal welchen Weg du wählst: Deine Aufgaben verwaltest du im **[Lern-Kanban-Board](#dein-lern-kanban-board)**, von „Zu erledigen“ über „In Bearbeitung“ nach „Done“.

---

## Definition of Done

Dein Projekt ist fertig, wenn **alle** Punkte erfüllt sind:

- [ ] Dein Repository ist **öffentlich** (public) und aus der Vorlage erstellt.
- [ ] Es enthält deine `compose.yml` und deinen Ordner `html/` – aber **keine** Laufzeitdaten (`kuma-data/`).
- [ ] Der Webserver wird auf **Port 8085** veröffentlicht.
- [ ] Auf `main` läuft der Webserver mit **Apache httpd** und liefert **deine** `html/index.html` aus.
- [ ] Die Umstellung auf Apache ist über einen **Pull Request** von `dev` nach `main` gemergt worden, **nachdem** der Test grün war.
- [ ] Das Abzeichen oben im README steht auf **passing**.
- [ ] Dein LXC-Container läuft mit genau dem Stand von `main` (`git pull` + `docker compose up -d`).
- [ ] Die Fragen aus [Phase 4](anleitung/04-workflow-verstehen.md) sind beantwortet (Heft oder `antworten.md` im Repo).
- [ ] Alle Pflichtkarten im [Kanban-Board](#dein-lern-kanban-board) stehen auf **Done**.

**Abgabe (Moodle):** der Link zu deinem Repository und der Link zu deinem gemergten Pull Request.

---

## Expertenauftrag (nur die Anforderungen)

> Bringe deinen Microcloud-Stack aus Modul 4 in ein öffentliches GitHub-Repository, das du aus dieser Vorlage erzeugst, und arbeite ab sofort nur noch über Git. Der vorgegebene Workflow muss auf `main` grün sein. Die Dienste werden einheitlich auf Port 8085 veröffentlicht. Der Webserver wird auf einem Branch `dev` auf Apache httpd umgestellt und erst nach grünem Test per Pull Request in `main` übernommen. Dein LXC-Container betreibt am Ende den Stand von `main`. Gepusht wird per SSH-Schlüssel.

Wenn du fertig bist: Erkläre in einer `antworten.md`, **was** der Workflow in jedem Schritt prüft und **warum** Schritt 7 die Inhalte vergleicht, statt nur den Port zu testen.

---

## Standardauftrag (Phasen mit Zielen)

| Phase | Ziel – woran erkennst du, dass du fertig bist? | Zeit | Anleitung |
|---|---|---|---|
| **HA** | Dein GitHub-Account ist eingerichtet, die E-Mail bestätigt, **2FA aktiv**, die Recovery-Codes sind gesichert. *(Hausaufgabe vor der Projektwoche)* | zu Hause | [00 – Hausaufgabe GitHub-Account](anleitung/00-hausaufgabe-github-account.md) |
| **0** | Du kennst Ziel, Ablauf und *Definition of Done*. Dein Kanban-Board ist geöffnet und die Karte *Projektstart* steht in **In Bearbeitung**. | 30′ | [Lern-Kanban-Board](#dein-lern-kanban-board) (Einstieg im Plenum) |
| **1** | Auf deinem LXC ist Git eingerichtet (`git config`), ein eigener **SSH-Schlüssel** ist bei GitHub hinterlegt und `ssh -T git@github.com` begrüßt dich mit deinem Benutzernamen. | 30′ | [01 – SSH-Schlüssel](anleitung/01-ssh-key.md) |
| **2** | Dein öffentliches Repo ist aus der Vorlage erzeugt und nach `~/microcloud` geklont. Dein Stack aus Modul 4 ist committet und gepusht. Der erste CI-Lauf ist **rot** – und du kannst erklären, warum. | 45′ | [02 – Repo anlegen & Stack einspielen](anleitung/02-repo-anlegen-und-stack-einspielen.md) |
| **3** | Der Stack veröffentlicht Port **8085**, läuft lokal und die CI ist **grün**. | 30′ | [03 – Port anpassen, erster grüner Build](anleitung/03-port-anpassen-erster-gruener-build.md) |
| **4** | Du kannst jeden Schritt des Workflows erklären und die CI/CD-Fachbegriffe zuordnen. | 45′ | [04 – Den Workflow verstehen](anleitung/04-workflow-verstehen.md) |
| **5** | Auf dem Branch `dev` läuft **Apache httpd**, liefert deine Seite aus und die CI auf `dev` ist **grün**. `main` ist unverändert. | 90′ | [05 – dev-Branch: Umstieg auf Apache](anleitung/05-dev-branch-apache.md) |
| **6** | Ein Pull Request `dev → main` ist nach grünem Test gemergt, dein LXC betreibt den neuen Stand von `main`. | 45′ | [06 – Pull Request & Merge](anleitung/06-pull-request-und-merge.md) |
| **+** | Zusatz für Schnelle: siehe unten. | Rest | [07 – Zusatz](anleitung/07-zusatz-cicd-test.md) |

### Hilfeseiten

- [Git-Spickzettel](hilfe/git-spickzettel.md) – alle Befehle dieser Woche auf einer Seite
- [CI-Log lesen](hilfe/ci-log-lesen.md) – wo finde ich, *warum* es rot ist?
- [Begriffe CI/CD](hilfe/begriffe-cicd.md) – Workflow, Job, Step, Runner, Event …
- [Typische Fehler und Lösungen](hilfe/typische-fehler.md) – `Permission denied (publickey)`, `rejected`, Port belegt …

---

## Zusatz und Differenzierung

- **CI/CD weitergedacht:** Bearbeite das Wiki [jbtls/cicd-test](https://github.com/jbtls/cicd-test/wiki): Dort baut eine Pipeline ein eigenes Docker-Image, testet es und veröffentlicht es als Release in der GitHub Container Registry. Hinweise: [07 – Zusatz](anleitung/07-zusatz-cicd-test.md).
- **Eigener Test:** Erweitere den Workflow um einen Schritt, der prüft, ob Uptime Kuma (Bonus aus Modul 4) auf Port 3001 antwortet. Teste deine Änderung auf einem eigenen Branch!
- **Release:** Markiere den fertigen Stand mit einem Tag `v1.0.0` und erstelle daraus auf GitHub ein *Release* mit einer kurzen Beschreibung deiner Änderungen.

---

## Wichtig: Datenschutz und Kosten

- Dein Repository ist **öffentlich** – jeder im Internet kann es lesen. Schreibe in deine `index.html` höchstens deinen **Vornamen oder ein Kürzel**. Passwörter, Schlüssel und private Daten gehören niemals in ein Repository.
- Für dieses Projekt entstehen **keine Kosten**: In öffentlichen Repositories sind GitHub Actions auf Standard-Runnern kostenlos. Du brauchst weder eine Kreditkarte noch ein kostenpflichtiges Abo.
