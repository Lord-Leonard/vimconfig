<%@ Page Language="c#" %>
<%
  var project = Request.QueryString["project"];
  var mandant = p2plus.DBEnv.DBEnv.getMandant();
%>

<!doctype html>
<html lang="de">
<head>
  <meta charset="utf-8"/>
  <title>Budgetdaten erfassen</title>
  <%: Scripts.Render(JSBundlePath.Head) %>
  <link href="../Styles/base.css" rel="stylesheet"/>
  <link href="../../css/wbds/dist/tailwind.css" rel="stylesheet"/>
  <link type="text/css" rel="stylesheet" href="../../node_modules/@materializecss/materialize/dist/css/materialize.min.css" media="screen,projection"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="icon" href="../../FavIcon.ico"/>

  <script>
    <% if (mandant.Equals("SP24"))
       { %>
      document.documentElement.setAttribute('theme', 'sp');
      localStorage.setItem('theme', 'sp');
    <% }
       if (mandant.Equals("WB"))
       { %>
      document.documentElement.setAttribute('theme', 'wb');
      localStorage.setItem('theme', 'wb');
    <% } %>
  </script>

  <%-- Komponentne --%>
  <script src="../components/WbdsBudgetUebersicht.js" type="module"></script>
  <script src="WbdsBudgetdatenWizard.js" type="module"></script>
  <script src="../components/WbdsWizardCard.js" type="module"></script>
  <script src="../components/WbdsContact.js" type="module"></script>
  <script src="../components/wbdsSelect.js" type="module"></script>
</head>

<body class="overflow-clip bg-grey-100">

<header>
  <nav class="mb-1 nav-extended">
    <div class="nav-wrapper">
      <a class="brand-logo left">Budget erfassen</a>
      <ul id="nav-mobile" class="right">
        <li>
          <span id="header-infos" class="hide-on-med-and-down"></span>
        </li>
        <li>
          <a id="HILFE" href="../../logical-modules/help/startpage/WbdsStartpage.aspx">
            <i class="text-3xl material-symbols-outlined symbol-fill">
              help
            </i>
          </a>
        </li>
        <li>
          <a class="ml-0 red white-text btn-small modal-trigger" id="exitButton" href="#modal2">
            <span class="material-symbols-outlined">
              close
            </span>
          </a>
        </li>
      </ul>
      <wbds-environment-icon></wbds-environment-icon>
    </div>
  </nav>

  <!-- Modal Structure -->
  <div id="modal2" class="modal">
    <div class="modal-content">
      <h5>Wollen Sie den Wizard abbrechen?</h5>
      <p>
        Abbrechen löscht alle Daten! Neustart erforderlich, um fortzufahren.
      </p>
    </div>
    <div class="modal-footer">
      <a href="#" class="modal-close waves-effect btn-flat">Nein</a>
      <a href="#" class="modal-close waves-effect btn-flat" onclick="wbds.wizard.cancelWizard('objectId');">Ja</a>
    </div>
  </div>

</header>

<div class="mx-8 mt-7 mb-7 hide-on-med-and-down">
  <ul class="tabs z-depth-1 !bg-white rounded-lg grid grid-cols-9" id="statusBand">
    <li class="tab col pointer" id="status_1">
      <a class="status">1 - Gesamtbudget</a>
    </li>
    <li class="tab col pointer" id="status_2">
      <a class="status">2 - BGK</a>
    </li>
    <li class="tab col pointer" id="status_3">
      <a class="status">3 - Intertrade</a>
    </li>
    <li class="tab col pointer" id="status_4">
      <a class="status">4 - Iamsat</a>
    </li>
    <li class="tab col pointer" id="status_5">
      <a class="status">5 - Nachunternehmer</a>
    </li>
    <li class="tab col pointer" id="status_6">
      <a class="status">6 - Material</a>
    </li>
    <li class="tab col pointer" id="status_7">
      <a class="status">7 - Miete</a>
    </li>
    <li class="tab col pointer" id="status_8">
      <a class="status">8 - Abfall / Schuttmulde</a>
    </li>
    <li class="tab col pointer" id="status_9">
      <a class="status">9 - Sonstiges</a>
    </li>
  </ul>
</div>

<main>
  <wbds-budgetdaten-wizard></wbds-budgetdaten-wizard>
</main>

<footer class="absolute bottom-0 z-10 w-full bg-grey-100 row">
  <div class="hidden progress" id="progress">
    <div class="indeterminate"></div>
  </div>

  <button class="s1 offset-s1 offset-m3 offset-l4 flex justify-center"
          id="prevButton">
    <i class="material-symbols-outlined text-[var(--primary-color)] medium pointer">chevron_left</i>
  </button>

  <button class="s1 offset-s11 offset-m8 offset-l7 flex justify-center"
          id="nextButton">
    <i class="material-symbols-outlined text-primary-500 medium pointer">chevron_right</i>
  </button>

  <button class="hidden text-xl s9 m4 l3 waves-effect waves-light btn" id="submitButton">
    Geschäftspartner erstellen
  </button>
</footer>

<script src="<%= Page.ResolveUrl("~/WebObjects/translations.aspx") %>"></script>
<script src="<%= Page.ResolveUrl("~/WebObjects/settings.aspx") %>"></script>
<%: Scripts.Render(JSBundlePath.Common) %>
<script id="init-page-context">
      (function() {
        app.context["project"] = "<%= project %>";
        app.context["nls_Monat"] = "<%= Options.nlsOptions("0:,1:Januar,2:Februar,3:M&auml;rz,4:April,5:Mai,6:Juni,7:Juli,8:August,9:September,10:Oktober,11:November,12:Dezember") %>";
        app.context["nls_Jahr"] = "<%= Options.nlsOptions("0:,2019:2019,2020:2020,2021:2021,2022:2022,2023:2023,2024:2024,2025:2025,2026:2026,2027:2027,2028:2028,2029:2029,2030:2030") %>";
        app.context["nls_Gewerk"] = "<%= Options.sqlOptions("GEWERK", "SELECT GEWERK, BENENNUNG FROM GEWERK ORDER BY GEWERK", true) %>";
        app.context["nls_Kostenart"] = "<%= Options.sqlOptions("KOSTENART", "SELECT KOSTENART, BENENNUNG FROM KOSTENART WHERE ANP_PLANDATENRELEVANT = 1", true) %>";
      })();
  </script>
<script id="page-script" src="<%: WebUtils.getScriptPath() %>" type="module"></script>
<script id="wizard-scritp" src="../../wbds/Wizards/Scripts/Wizard.js"></script>
<script type="text/javascript" src="../../node_modules/@materializecss/materialize/dist/js/materialize.min.js"></script>

</body>
</html>
