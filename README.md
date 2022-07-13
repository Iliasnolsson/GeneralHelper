# GeneralHelper

A Swift Package which consists of a large amount of extensions & models for simplified and added functionality.

## Color 
Easily convert between color formats, HSBA, RGBA, UIColor & CGColor. Also includes methods to increase brightness, interpolating color & higlighting 
```
Color (Protocol)
HSBA 
RGBA
```
Simplify support dark/light mode:
``` swift
static var backgroundColor: DynamicColor = .init(
    .dark(RGBA(r255: 44, g255: 44, b255: 46)),
    .light(.white))
```

## Date 
Big help for creating calendar apps, easier to move between weeks & days. 
```
Day
DayOfWeek
Time
Timespan
Week
```

## Enums
A large amount of enums which helps in making code easier to read & helps when dealing with math, axis, color profiles & graphics/design apps
```
Axis
AxisLine
RectangleAnchor 
Side
SideHorizontal
SideVertical
MathSymbol
SpecialMathSymbol
... and a bunch more
```

## Extensions
Easier creation of scalable fonts & SF Fonts: 
- UIFont.rounded for SF Pro Rounded, parameters for weight exists
- UIFont.display for SF Pro Rounded, parameters for weight exists

```swift
label.font = .display(ofSize: .largeTitle, weight: .bold)
label.font = UIFont(name: "Helvetica", size: 20).with(style: .caption1, maxPointSize: 15)
        
label.font = .rounded(ofSize: .heading, maxPointSize: 20)
label.font = .rounded(ofSize: 20, weight: .black)
```




## Views
Simplifiers, utility views & Subclasses of all UIKit views have been made which automatically sets translatesAutoresizingMaskIntoConstraints to false. Usefull when not using Storyboards. 

