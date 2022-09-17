# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Flix Part 2

### User Stories

#### REQUIRED (10pts)
- [x] (5pts) User can tap a cell to see more details about a particular movie.
- [x] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [x] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [x] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

### App Walkthrough GIF

### Notes
During this second part, knowing AutoLayout is a must to make sure the interface work on multiple devices. The thing that challenged me in a good way is exploring how the Movie Database API works and extracting certain data from it.

---

## Flix Part 1

#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [x] (2pt) User can view the app on various device sizes and orientations.
- [x] (1pt) Run your app on a real device.

### App Walkthrough GIF

**iPhone 14 Pro Max Demo**

![](https://i.imgur.com/xDZpI8E.gif)
![](https://i.imgur.com/FYKkRdF.png)

**iPhone 8 Demo**

![](https://i.imgur.com/nAZatF5.gif)
![](https://i.imgur.com/IIf3tSh.png)

### Notes

The networking component was made with the help of AlamoFireImage installed via CocoaPods. The most challenging part was applying AutoLayout rules since in my experience SwiftUI handles all this details for us.
