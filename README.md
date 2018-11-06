# iOS Practical Code Test

Using Swift 4.0 or higher, create an iPhone application that allows a user to search StackOverflow for questions via their __tags__.

#### Requirements

1. __No__ 3rd party libraries or frameworks may be used.
2. The app must display correctly across all iPhone screen sizes.
3. The app must support iOS 9.0 and higher.
4. The project should be hosted in a Git repository. If the repository is on your local machine, a compressed file of the whole repository can be submitted. If the repository is hosted online, please provide us with the

### StackOverflow API

#### API Documentation
[https://api.stackexchange.com/docs](https://api.stackexchange.com/docs)

#### /questions API Method Documentation
[https://api.stackexchange.com/docs/questions](https://api.stackexchange.com/docs/questions)

#### Sample Request
[https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=swift%203&site=stackoverflow&filter=withbody](https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=swift%203&site=stackoverflow&filter=withbody)

__Note:__ The __‘filter=withbody’__ parameter is required in order to return the question body. This is not mentioned in the methods documentation.

### Search Questions

![SCR01](https://i.imgur.com/PTGxOvs.png) ![SCR02](https://i.imgur.com/zZpwyi8.png)

#### Requirements

1. On app launch the user should be presented with the screen SCR01
2. The search should be performed after the user enters a keyword and taps the ‘Search’ button.
3. The search results should be displayed as per screen SCR02.
4. The search must be limited to 20 results.
5. For each result the following details should be displayed:
    - Title
    - The owners name
    - Number of votes, answers & views
    - If the question is answered, the checkmark should be shown (check.png)
6. Selecting a result will load the SCR03 screen

### View Question

![SCR03](https://i.imgur.com/9136d5B.png)

#### Requirements

1. The title of the question should be displayed in a fixed-height grey view and fixed to the top of the screen.
2. The HTML body of the question should scrollable.
3. The owners details should be displayed in a fixed-height grey view, fixed to the bottom of the screen. It should display the following details: 
    - The owners name
    - The owners profile image
    - The owners reputation
    - The date the question was posted
4. The tags should be displayed in a fixed-height view above the owners details and below the questions body.

### Design Guide

![Design Guide 1](https://i.imgur.com/mU0fGTN.png)
![Design Guide 2](https://i.imgur.com/0CqVEIF.png)