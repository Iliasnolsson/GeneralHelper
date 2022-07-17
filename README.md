# GeneralHelper

A Swift Package which consists of a large amount of extensions & models for simplified and added functionality.

## Color 
Easily convert between color formats, HSBA, RGBA, UIColor & CGColor. Also includes methods to increase brightness, interpolating color & higlighting 
- Color (Protocol)
- HSBA 
- RGBA
- DynamicColor

Simplify support dark/light mode:
``` swift
static var backgroundColor: DynamicColor = .init(
    .dark(RGBA(r255: 44, g255: 44, b255: 46)),
    .light(.white))
    
view.backgroundColor = backgroundColor.uiColor()
```

## Date 
Big help for creating calendar apps through a library of calendar structs with quite a lot of helper methods.
- Day
- DayOfWeek
- Time
- Timespan
- Week

Easier to move between weeks, days & months:
```swift
var nextWeek = Day.today.week.nextWeek()
print("Next week is week: ", nextWeek.weekOfYear)
print("The year is: ", nextWeek.year)
```

Handling of timespans:
```swift
let swimmingEvent = Timespan(
    from: .init(hour: 15, minute: 30),
    to: .init(hour: 16, minute: 30))
let bowlingEvent = Timespan(
    from: .init(hour: 16, minute: 0),
    to: .init(hour: 16, minute: 30))

if swimmingEvent.isClipping(bowlingEvent) {
    print("Events are overlapping")
}
```

## Animate CALayer 
Makes it quicker and easier to animate CALayer. All properties otherwise animatable through traditional methods are accessible through this approach. 

```swift
// Animate Opacity
CALayer.animate(layer: view.layer, valueKey: \.opacity,
                to: 0, duration: 0.4, option: .easeIn)

// Animate Corner Radius
CALayer.animate(layer: view.layer, valueKey: \.cornerRadius,
                to: 10, duration: 0.3, option: .easeInQuad)

// Animate Background Color
let color = CGColor(gray: 1, alpha: 0)
CALayer.animate(layer: view.layer, valueKey: \.backgroundColor,
                to: color, duration: 0.5, option: .easeInQuad)
                
// Animate Gradient
let gradientLayer = CAGradientLayer()
let newColors: [CGColor] = [.red, .green]
CALayer.animate(layer: gradientLayer, valueKey: \.colors,
                to: newColors, duration: 1.2, option: .easeOut)
```
## Enums
A large amount of enums which helps in making code easier to read & helps when dealing with math, axis, color profiles & graphics/design apps
- Axis
- AxisLine
- RectangleAnchor 
- Side
-  SideHorizontal
- SideVertical
- MathSymbol
- SpecialMathSymbol
... and a bunch more

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


