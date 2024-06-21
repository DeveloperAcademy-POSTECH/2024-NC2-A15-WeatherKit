# 2024-NC2-A15-WeatherKit
## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About WeatherKit!


`WeatherKit` 

- 현재 상태, 강수량, 시간별, 일일 예보를 포함한 다양한 날씨 정보를 제공하는 프레임워크
- 기온, 강수량, 바람, UV 지수 등에 대한 **최대 10일간의 시간별 예보**를 제공

`WeatherKit 사용가능한 버전` 

iOS 16.0+  |  iPadOS 16.0+  |  Mac Catalyst 16.0+  |  macOS 13.0+  |  tvOS 16.0+  |  visionOS 1.0+  |  watchOS 9.0+

`WeatherKit에서 제공하는 데이터`

- 온도, 최고 온도, 최저 온도, 체감 온도, 강수 확률, 강수 강도, 강수량, 강설량, 기압, 기압 추세, 이슬점, 습도, 구름량, 자외선 지수, 풍향, 돌풍, 풍속, 날씨 상태, 달의 위상, 달의 뜸, 달의 짐, 위험도, 가시성, 일출, 일몰

`WeatherKit 사용 방법`

1. Apple developer Program 가입
2. Certificates, Identifiers & Profiles 섹션에서 App ID와 API키 설정
3. Xcode에서 WeatherKit 활성화
4. 날씨 데이터 요청

## 🎯 What we focus on?

### 우리가 생각하는 **WeatherKit**의 가치

- 날씨 정보를 제공하여 사용자가 확인하고 미리 대비할 수 있게 도와주는 것

### 10일간 일일 예보 데이터(Daily forecast)를 활용해 사용자에게 유용한 정보로 변환하자!

- WeatherKit과 CoreLocation을 활용하여 사용자의 현재 지역 날씨를 받아오고, 그 정보를 가공하여 사용자에게 유용한 정보로 보여주자!

## 💼 Use Case

### **날씨 데이터**를 활용하여 사용자에게 유용한 정보를 제공할 수 있는 상황은 언제일까?

- 여러 차주분의 경험을 듣고 발견한 인사이트
    - 세차와 날씨와 밀접한 관계가 있다
 
<br>
 
``` 
😩 “세차하고 얼마 지나지 않아 비가 오면 너무 슬퍼요…”

😭 “세차하고 그 다음날에 비가 왔어요……”
```


## 🖼️ Prototype

![세차데이 목업1](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A15-WeatherKit/assets/54520200/2d9f2351-c35a-4050-9594-bd4ee19bdbe5)

<img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A15-WeatherKit/assets/54520200/cb4dec3f-33db-4fcc-ae6d-5e40ad0aecfc"  width="400" />

<img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A15-WeatherKit/assets/54520200/8ec6ea7e-321c-44ec-b67a-e5dbf30c420c"  width="360" />


## 🛠️ About Code

```swift
import CoreLocation
import SwiftUI
import WeatherKit

// 클래스의 모든 메서드와 속성이 메인 스레드에서 실행됨.
@MainActor
class WeatherManager: ObservableObject {
    // WeatherKit의 공유 인스턴스를 가져옴
    private let weatherService = WeatherService.shared
    
    @Published var dailyWeather: [DayWeather] = []
    @Published var precipitationProbability: Double?
    @Published var rainyDays: Int = 0
    @Published var precipitationUpperDays: Int = 0
    
    func fetchWeather(for location: CLLocation) async {
        do {
            let weather = try await weatherService.weather(for: location)
            dailyWeather = weather.dailyForecast.forecast.prefix(10).map { $0 }
            
            // 비오는 날이나 확률높은 날 계산
            for day in dailyWeather {
                let condition = CWWeatherCondition.convertCondition(condition: day.condition.rawValue)
                
                if condition == .rain {
                    rainyDays += 1
                }
                
                if day.precipitationChance >= 0.6 {
                    precipitationUpperDays += 1
                }
             }
        } catch {
            print("Failed to fetch weather data: \(error)")
        }
    }
}

```

- 날씨 정보를 불러오는 WeatherManager 클래스

<br>

---

<br>

### 코드 세부 설명

```swift
// WeatherKit의 공유 인스턴스를 가져옴
private let weatherService = WeatherService.shared
```

- WeatherService 클래스를 싱글톤 패턴으로 사용하기 위하여 WeatherService.shared를 가져옴

<br>

```swift
let weather = try await weatherService.weather(for: location)
```

- WeatherSevice 클래스의 weather 메소드는 CLLocation 타입의 위치 정보를 통해서 해당 지역의 날씨 정보를 받아 올 수 있습니다.
- WeatherService 클래스의 weather 메서드는 Weather 타입 객체 반환함

<br>

```swift
var dailyWeather: [DayWeather] = []
...
dailyWeather = weather.dailyForecast.forecast.prefix(10).map { $0 }
```

- Weather 클래스의 프로퍼티는 다음과 같습니다. 이 중 dailyForecast 프로퍼티를 사용했습니다.
- dailyForecast는 Forecast<DayWeather> 타입이고, Forecast의 설명은 다음과 같습니다.

<br>

```swift
struct Forecast<Element> 
	where Element : Decodable, Element : Encodable, Element : Equatable
```

- Forecast 구조체 내부의 forecast 프로퍼티는 [Element]를 반환합니다.
- 따라서 해당 코드로 DayWeather 객체 10개를 배열로 얻을 수 있게 됩니다.
- DayWeather 구조체 내부에는 최고기온, 강수확률 등의 다양한 정보가 프로퍼티로 존재합니다.

<br>
