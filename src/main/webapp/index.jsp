<!--
  Copyright (c) 2020, 2023 IBM Corp.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<%@ page pageEncoding="utf8" import="java.util.*" contentType="text/html; charset=utf8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<html lang="en">
 <head>
  <title>MainCrewService</title>
  <script type="text/javascript" src="js/mongo.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Asap" rel="stylesheet">
  <link rel="stylesheet" href="css/mongo.css">
  <link rel="stylesheet" href="css/toast.css">
 </head>
 <body>
  <section id="appIntro" role="main">
   <div id="titleSection">
    <% String addURL=System.getProperty("addcrewservice.url"); %>
    <% String deleteURL=System.getProperty("deletecrewservice.url"); %>
    <% String updateURL=System.getProperty("updatecrewservice.url"); %>
    <div hidden id="addURLID"><%=addURL%></div>
    <div hidden id="deleteURLID"><%=deleteURL%></div>
    <div hidden id="updateURLID"><%=updateURL%></div>
    <h1 id="appTitle">MainCrewService</h1>
    <div class="line"></div>
    <div class="headerImage"></div>
    <h2>Open Liberty microservices modified from <a href="https://github.com/OpenLiberty/guide-mongodb-intro">guide-mongodb-intro</a></h2>
    <p>These microservices use REST endpoints and Bean Validation to store data in MongoDB.</p>
   </div>
   <div id="usersContainer" class="hFlexContainer">
    <form id="userCreation" class="vFlexContainer">
     <h4 id="createCrewMember" class="flexSelfCenter">Register Crew Member</h4>
     <div id="name" class="vFlexContainer inputLine">
      <label for="crewMemberName">Name</label>
      <input id="crewMemberName" class="textBox" type="text">
     </div>
     <div id="iD" class="vFlexContainer inputLine">
      <label for="crewMemberID">ID Number</label>
      <input id="crewMemberID" class="textBox" type="text">
     </div>
     <div id="rank" class="vFlexContainer inputLine">
      <label for="crewMemberRank">Rank</label>
      <select id="crewMemberRank">
       <option>Captain</option>
       <option>Officer</option>
       <option>Engineer</option>
      </select>
     </div>
     <button type="submit" class="buttons" onclick="addCrewMember(event)" >Register Crew Member</button>
     
    </form>
    <div id="userDisplay" class="vFlexContainer">
     <h4 id="crewMembers" class="flexSelfCenter">Crew Members</h4>
     <div id="clickToEdit" class="flexSelfCenter">(click to edit)</div>
     <div id="userBoxes" class="flexBox hFlexContainer">
     </div>
    </div>
    <form id="userUpdate" class="hidden vFlexContainer">
     <h4 id="updateCrewMember" class="flexSelfCenter">Update Crew Member</h4>
     <div id="id" class="vFlexContainer inputLine">
      <label for="docID">_id</label>
      <input id="docID" class="textBox" type="text" disabled>
     </div>
     <div id="newName" class="vFlexContainer inputLine">
      <label for="updateCrewMemberName">Name</label>
      <input id="updateCrewMemberName" class="textBox" type="text">
     </div>
     <div id="newID" class="vFlexContainer inputLine">
      <label for="updateCrewMemberID">ID Number</label>
      <input id="updateCrewMemberID" class="textBox" type="text">
     </div>
     <div id="newRank" class="vFlexContainer inputLine">
      <label for="updateCrewMemberRank">Rank</label>
      <select id="updateCrewMemberRank">
       <option>Captain</option>
       <option>Officer</option>
       <option>Engineer</option>
      </select>
     </div>
     <button type="submit" class="buttons" onclick="updateCrewMember(event)" >Update Crew Member</button>
    </form>
    <div id="docDisplay" class="flexBox vFlexContainer">
     <h4 id="docTitle" class="flexSelfCenter">MongoDB Documents</h4>
     <pre id="docText"></pre>
    </div>
   </div>
  </section>
  <footer class="bodyFooter">
   <div class="bodyFooterLink">
    <a id="licenseLink" href="https://github.com/OpenLiberty/open-liberty/blob/release/LICENSE">License</a>
    <a href="https://twitter.com/OpenLibertyIO">Twitter</a>
    <a href="https://github.com/OpenLiberty">GitHub</a>
    <a href="https://openliberty.io/">openliberty.io</a>
   </div>
   <p id="footerText">an IBM open source project</p>
   <p id="footerCopyright">&copy;Copyright IBM Corp. 2020, 2023</p>
  </footer>
  <div id="toast"></div>
  <script>
   refreshDocDisplay();
  </script>
 </body>
</html>
