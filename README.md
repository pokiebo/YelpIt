# Project 2 - *Name of App Here*

**Name of your app** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **30** hours spent in total

## User Stories

The following **required** functionality is completed:

- [ ] Search results page
   - [ ] Table rows should be dynamic height according to the content height.
   - [ ] Custom cells should have the proper Auto Layout constraints.
   - [ ] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [ ] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [ ] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [ ] The filters table should be organized into sections as in the mock.
   - [ ] You can use the default UISwitch for on/off states.
   - [ ] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

The following **optional** features are implemented:

- [X] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [X] Implement map view of restaurant results.
- [X] Filter page
   - [X] Implement a custom switch instead of the default UISwitch.
   - [X] Distance filter should expand as in the real Yelp app
   - [X] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [ ] Implement the restaurant detail page.



## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://imgur.com/a/4xaitfl' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).



## License

    Copyright [2018] [Sudipta Bhowmik]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.