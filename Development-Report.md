# openCX-T7G3 ESOF Teas Development Report

Welcome to the documentation pages of the Schedule IT of **openCX**!

- Business modeling
  - [Product Vision](#Product-Vision)
  - [Elevator Pitch](#Elevator-Pitch)
- Requirements
  - [Use Case Diagram](#Use-case-diagram)
  - [User stories](#User-stories)
  - [Domain model](#Domain-model)
- Architecture and Design
  - [Logical architecture](#Logical-architecture)
  - [Physical architecture](#Physical-architecture)
  - [Prototype](#Prototype)
- [Implementation](#Implementation)
- [Test](#Test)
- [Configuration and change management](#Configuration-and-change-management)
- [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

Clara Moreira, Flávia Carvalhido, João Dossena, Leonor Gomes, Luís Assunção.

---

## Product Vision

Crafting YOUR conference schedule

---

## Elevator Pitch

Conference productivity? Let's make it a thing! You don't have to look for talks, we find them for you! You don't need to clear your schedule to go to talks, we fit them right in your schedule for you! Going to a conference was never easier.

---

## Requirements
As a schedule application, the main requirements of our product
consist in generating a personalized and optimized schedule to each conference attendee based on their respective interests.
This schedule should then be displayed in a manner that is aesthetically appealing and intuitive to the user. 
The app must also allow the conference admin to enter the conference informations, such as the list of talks, the conference schedule and the respective tags.
As a mobile application the product needs to have a performance tailored to the capabilities of smartphones.


---

### Use case diagram

![use case diagram](./img/use_case_diagram.png)

**Register**

- Actor: Attendee or Conference Admin
- Description: Attendees and Conference Admins register so that they can use the app and register in the system.
- Preconditions and Postconditions: Before the Register there is nothing, as a User's story begins registering so they can access their info later.
- Normal Flow: During register, user's provide their email, a password, name and date of birth. After registering, user's usually carry on and make their own profiles, discover the app's functionalities.
- Alternative Flows: There are no alternate actions for the register process.

**Login/Profile**

- Actor: Attendee or Conference Admin
- Description: As of the act of registering, the users get access through login with email and password and have their own profile
- Preconditions and Postconditions: To perform the login action, one must first register. Same goes for the profile.
- Normal Flow: During login, email and password should be provided in order to access one's account. In the profile, people can visualize their own profile info and they can edit it.
- Alternate Flows: User's have to login to access the app, howeer they do not have to necessarily go through their profile everytime they login, they can skip ahead and do something else in the app.

**Choose tags of their interest**

- Actor: Attendee
- Description: Every attendee must have tags of themes in which they are interested in. Therefore, after register and also later on while using the app, attendees can choose (add or delete) tags. This is extremelly important for later generation of the schedule.
- Preconditions and postconditions: To choose tags, one must be logged in the app and have chosen the conference they will attend. After choosing the tags, the app has more information about the user's interests and will make a schedule tailored to them.
- Normal flow: After choosing the tags, the user may do something else in the app but the most common action would be to prioritize those tags in order for the app to take into consideration how much the user likes a theme compared to other.
- Alternate flow: Choosing tags is mandatory in order for the app to generate schedules therefore this is a mandatory step.

**Prioritize tags**

- Actor: Attendee
- Description: The attendees can order the tags they choose according to their preferences,after register and also later on while using the app.
- Preconditions and postconditions: Before prioritizing tags, the attendee must have selected the tags of his interest. After prioritizing tags,the app can generate a schedule even more tailored to the attendee.
- Normal Flow: The user should prioritize the tags after choosing them. After prioritizing the tags, the user can navigative the rest of the app.
- Alternate Flows: The users can prioritize tags whenever they want. Prioritizing tags is not a mandatory step, so the user can step over it.

**Choose conference to attend**

- Actor: Attendee
- Description: The attendee chooses the conference they want to attend so that the app can start generating a schedule for the attendee.
- Preconditions and postconditions: For the attendee to choose the conference, the conference admin has to have already uploaded the schedule on to the app. 
After choosing the conference, the attendee can choose the tags according to their interests.
- Normal Flow: The attendee chooses from a list of available conferences the one he wishes to attend.
- Alternate Flows: The attendee must choose a conference for the app to generate a schedule. If he does not choose a conference, nothing happens and there's no generated schedule.

**Upload CV**

- Actor: Attendee
- Description: The attendees can upload their own CV for conference admins to check and share with the speakers and/or companies.
- Preconditions and postconditions: In order to upload the CV, the attendee must be logged in and after upload, the conference admin has access to the attendees' CVs. Admins can therefore share the CVs.
- Normal Flow: To upload the CV, the attendee must choose a file from the device containing their CV and upload it to the app, to their own profile. Therefore, whenever they are in a talk, the conference admin can have access to their profile and check their CV, sharing it with the speaker or other bodies involved.
- Alternate Flows: A attendee may choose not to upload their CV at all. This is an optional use case.

**Have a Generated Schedule that fits own Schedule**

- Actor: Attendee
- Description:The ateendes are presented with a costumized conference schedule, according to their interests. This schedule is generated in such a way that it does not interfere with previous activities the user has scheduled.
- Preconditions and postconditions: There has to be a selected conference for the app to generate a schedule based on the attendee's interests. Afterwards, the attendee will have a personalized schedule just for them.
- Normal Flow: The attendee, after picking a conference, gets a automatically generated schedule based on their interests.
- Alternate Flows: There are no alternate flows to this use case.

**Consult Generated Talk Schedule**

- Actor: Attendee
- Description: The attendees are able to consult their generated talk schedule.
- Preconditions and postconditions: The attendee must be logged in and also have picked the conference he/she wants to participate in and the keywords he/she is interested in. After the schedule is generated, the attendee already has his/her own schedule to attend the conference and can consult it.
- Normal Flow: After choosing the conference and keywords of interest, the schedule is generated. The attendee will be able to open and consult it.
- Alternate Flows:After the schedule is generated, the attendee can check it whenever he/she wants.

**Customize generated schedule**

- Actor: Attendee
- Description: The Attendee may want to customize the generated schedule: adding talks, deleting talks, choosing a time frame that must be clear (break time), for example.
- Preconditions and postconditions: There needs to be a generated schedule already for users to customize it. After customization, the user's schedule is updated and saved to the database for later consulting.
- Normal Flow: The user opens the schedule, taps the 'Edit' button and may add, delete or even move talks around. Afterwards they save the changes so that the schedule is updated and can be consulted later on.
- Alternate Flows: A user may choose not to edit the schedule at all or edit it and not save the changes.

**Consult speakers' social media profiles**

- Actor: Attendee
- Description: The attendees are able to consult speaker's social media profiles of the talks they are participating.
- Preconditions and postconditions: The attendee must already have the schedule generated.
- Normal Flow: After seeing the generated schedule, attendees may check the social media profiles of speakers from each of the talks in their schedule.
- Alternate Flows: Attendees may not check any social media profile, this is a complementary feature.

**Add conference talks, schedule and tags**

- Actor: Conference Admin
- Description: The conference Admin can add the conference information, such as its talks, the schedule and tag, so that they can be accessed later on by the attendees.
- Preconditions and postconditions: The Conference Admins need to be logged in and have a talk schedule ready to add to the app.
- Normal Flow: The Conference Admin adds the talks to the app and procedes to indicate the tags associated to them.
- Alternate Flows: This is a necessary step for the app to be able to generate schedules for the attendees.

**Check and share attendee's CVs**

- Actor: Conference Admin
- Description: The conference admin can consult and share the attendee's CVs with the bodies involved in the conference.
- Preconditions and postconditions: The attendees must have already uploaded their CVs for admins to check them and share them with other people.
- Normal Flow: The Conference Admin checks the participants of a talk and can access their profiles/CVs. They can therefore share them with someone else.
- Alternate Flows: The Conference Admin can opt to not use this feature or just not share the CVs.

---


### User stories

---

**Epic User Story** : As a conference attendee, I want to have a personalized schedule tailored to my interests.

---

![User story map](./img/user_story_map.png)

<br>

- As a conference admin, I want to upload talks, their schedule and their themes as keywords

**User interface mockups:**

![](./img/add_talk_display.png)

**Acceptance tests:**

**Value:** Must have

**Effort:** L

<br>

- As a user, I want to be able to login and register in the app

**User interface mockups:**

![](./img/login_display.png)

**Acceptance tests:**

**Value:** Should Have

**Effort:** M

<br>

- As an attendee, I wish to choose my interests from a list of keywords so that my schedule is made according to them.

**User interface mockups:**

![](./img/select_tags_display.jpg)

**Acceptance tests:**

**Value:** Must Have

**Effort:** M

<br>

- As an attendee, I want to have my own profile

**User interface mockups:**

**Acceptance tests:**

**Value:** Must Have

**Effort:** L

<br>

- As an attendee, I want to evaluate my interests quantitatively in keywords I choose so that talks about topics that interest me the most are prioritized.

**User interface mockups:**

**Acceptance tests:**

**Value:** Should Have

**Effort:** M

<br>

- As an attendee, I want to choose the conference that I will attend.

**User interface mockups:**

**Acceptance tests:**

**Value:** Should Have

**Effort:** M

<br>

- As an attendee, I want to upload my CV to the app for it to be shared by the conference admin

**User interface mockups:**

**Acceptance tests:**

**Value:** Could Have

**Effort:** M

<br>

- As a conference admin, I wish to receive the CV's of each talk attendees

**User interface mockups:**

**Acceptance tests:**

**Value:** Could Have

**Effort:** M

<br>

- As an attendee, I want to check the speaker's social media profiles

**User interface mockups:**

**Acceptance tests:**

**Value:** Could Have

**Effort:** M

<br>

- As an attendee, I want my own schedule to be compatible with the generated talk schedule

**User interface mockups:**

**Acceptance tests:**

**Value:** Could Have

**Effort:** L

<br>

- As an attendee, I want my own schedule to be compatible with the generated talk schedule
  **User interface mockups:**

**Acceptance tests:**

**Value:** Could Have

**Effort:** L

---

### Domain model

![Domain Model](./img/domain_model.png)

---

## Architecture and Design

The software architecture of the app contains all its key components and their relationships, from a logical and a physical point. All those key components and interactions between them are what makes the app.

---


### Logical architecture

![Logical architecture](./img/logical_architecture.png)

To structure our app on a high-level, we opted to use the MVC architectural pattern, since it is very recommended for this sort of project.

In the View component resides the user interface and front-end of our app: the display of our different app states and data.

The Model component contains all the app data: profiles, schedules, CVs, etc.

Last but not least, the Controller component that connects the Model to the View: the Model sends data for the View to display and the View sends user inputs for the Model to process.

The Model gets the data from the databases containing all the user and conference information and the View gets inputs from the user interactions with the GUI Pages.

### Physical architecture

![Physical architecture](./img/physical_layer.png)

We are using the Flutter framework because it was recommended to us by our teachers as it is the easiest with which to get acquainted and to work. For authentication purposes in the app, we opted to use Firebase as it appears to be the best option for our login system. The server is needed to save our app data like CVs, schedules, profiles, etc.

---

### Prototype

To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation

Regular product increments are a good practice of product management.

While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---

## Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:

- test plan describing the list of features to be tested and the testing methods and tools;
- test case specifications to verify the functionalities, using unit tests and acceptance tests.

A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---

## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).

---

## Project management

We used [Github Projects](https://github.com/features/project-management/com) as our only project management tool to organize the project.

---

## Evolution - contributions to open-cx

Describe your contribution to open-cx (iteration 5), linking to the appropriate pull requests, issues, documentation.
