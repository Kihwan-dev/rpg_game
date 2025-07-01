# 🕹️ 전투 RPG 게임 과제 시나리오

## 1️⃣ Intro : 과제 개요

### 🎯 목표

* 랜덤 기능, 파일 입출력, 객체지향 프로그래밍을 활용한 **전투 RPG 게임** 개발

---

## 2️⃣ 필수 정의 요소

### 🧩 Game 클래스

| 속성                       | 설명          |
| -------------------------- | ----------- |
| `Character character`      | 플레이어 캐릭터 객체 |
| `List<Monster> monsterList`| 몬스터 리스트     |
| `int killMonsterCount`     | 물리친 몬스터 수   |

#### 📦 메서드

* `startGame()`: 게임 시작 및 진행
* `battle()`: 캐릭터와 몬스터의 전투 처리
* `getRandomMonster()`: 몬스터 리스트에서 랜덤 추출

---

### 🧍 Character 클래스

| 속성            | 설명     |
| ------------- | ------ |
| `String name` | 캐릭터 이름 |
| `int hp`      | 체력     |
| `int ap`      | 공격력    |
| `int dp`      | 방어력    |

#### 📦 메서드

* `attackMonster(Monster monster)`
* `defend()`: 공격력과 몬스터 공격력을 비교해 체력 회복
* `showStatus()`: 캐릭터 상태 출력

---

### 👹 Monster 클래스

| 속성            | 설명         |
| --------------- | ---------- |
| `String name`   | 몬스터 이름     |
| `int hp`        | 체력         |
| `int ap`        | 공격력 최대치    |
| `int dp`        | 방어력 (기본 0) |

#### 📦 메서드

* `attackCharacter(Character character)`: 캐릭터 공격
* `showStatus()`: 몬스터 상태 출력

---

## 3️⃣ 필수 기능 가이드

### 📄 1. 파일 데이터 불러오기

* **`characters.txt`**: `체력,공격력,방어력`
* **`monsters.txt`**: `이름,체력,공격력 최대값`

```dart
File('characters.txt').readAsStringSync();
File('monsters.txt').readAsLinesSync();
```

---

### ✏️ 2. 캐릭터 이름 입력받기

* 조건: 빈 문자열 ❌, 특수문자/숫자 ❌
* 허용 문자: 한글, 영문 대소문자
* 정규표현식 사용 예: `RegExp(r'^[a-zA-Z가-힣]+$')`

---

### 🧾 3. 게임 결과 저장 기능

* `result.txt`에 캐릭터 이름, 남은 체력, 게임 결과(승/패) 저장
* 사용자 입력: “결과를 저장하시겠습니까? (y/n)”

---

### 🧱 4. 추상 클래스 구현

* 공통 속성/메서드를 가진 **`abstract class Entity`** 정의
* `Character` 와 `Monster` 클래스가 상속받아 메서드 오버라이드

---

## 4️⃣ 도전 기능

### 🎁 1. 보너스 체력 기능

* 30% 확률로 캐릭터의 체력 `+10`
* 출력 예: `'보너스 체력을 얻었습니다! 현재 체력: ${character.health}'`

---

### 🧪 2. 아이템 사용 기능

* 전투 중 `3` 선택 시 **공격력 2배**로 한 턴
* 한 번만 사용 가능

---

### 🛡️ 3. 몬스터 방어력 증가 기능

* **3턴마다 방어력 +2**
* 출력 예: `'${name}의 방어력이 증가했습니다! 현재 방어력: $defense’`

---

### 💡 4. 자유 추가 기능

* 필수 기능 완성 후 자유롭게 확장 가능

---

## ⚠️ 주의사항

* **파일 예외 처리 필수**
* **입력 검증 철저**
* **함수 분리, 가독성 중시**

---

## ✅ 코드 실행 예시
![](https://velog.velcdn.com/images/rlghks446/post/139e6ea8-1d9b-4e29-ba28-c521ef2a11a2/image.png)
![](https://velog.velcdn.com/images/rlghks446/post/18480a45-b6f4-4363-b585-d53e177e2d37/image.png)