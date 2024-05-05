# List App



## List Feed Feature Specs

### Story: Customer requests to see their feed

### Narrative #1

```
As an online customer
I want the app to automatically load my latest feed
So I can always see the newest feed
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
 When the customer requests to see their feed
 Then the app should display the latest feed from remote
  And replace the cache with the new feed
```

### Narrative #2

```
As an offline customer
I want the app to show the latest saved version of my feed
So I can always see the feed
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
  And there’s a cached version of the feed
 When the customer requests to see the feed
 Then the app should display the latest feed saved

Given the customer doesn't have connectivity
  And the cache is empty
 When the customer requests to see the feed
 Then the app should display an error message
```

## Use Cases

### Load Feed From Remote Use Case

#### Data:
- URL

#### Primary course (happy path):
1. Execute "Load Feed" command with above data.
2. System downloads data from the URL.
3. System validates downloaded data.
4. System creates image feed from valid data.
5. System delivers feed.

#### Invalid data – error course (sad path):
1. System delivers invalid data error.

#### No connectivity – error course (sad path):
1. System delivers connectivity error.

---

### Load(Retrieve) Feed From Cache Use Case

#### Primary course:
1. Execute "Load Feed" command with above data.
2. System retrieves feed data from cache.
4. System creates image feed from cached data.
5. System delivers image feed.

#### Retrieval error course (sad path):
1. System delivers error.

#### Empty cache course (sad path): 
1. System delivers no feed images.

---

### Cache(Save) Feed Use Case

#### Data:
- Image Feed

#### Primary course (happy path):
1. Execute "Save Feed" command with above data.
2. System deletes old cache data.
3. System encodes image feed.
5. System saves new cache data.
6. System delivers success message.

#### Deleting error course (sad path):
1. System delivers error.

#### Saving error course (sad path):
1. System delivers error.

---

## Flowchart

![Flow](https://github.com/afsalkp007/ListApp/assets/23147303/db817174-4f3e-4d24-af2a-492531d52dbf)

## Model Specs

### Feed Image

| Property        | Type                |
|-----------------|---------------------|
| `name`          | `String`            |
| `country`       | `String`            |
| `alpha_two_code`| `String`            |
| `state-province`| `String` (optional) |
| `web_pages`     | `[String]`          |

### Payload contract

```
GET /feed

200 RESPONSE

[
    {
      "domains": [
        "mbzuai.ac.ae"
      ],
      "state-province": "Abu Dhabi",
      "name": "Mohamed bin Zayed University of Artificial Intelligence (MBZUAI)",
      "web_pages": [
        "https://mbzuai.ac.ae/"
      ],
      "country": "United Arab Emirates",
      "alpha_two_code": "AE"
    },
    {
      "name": "American College Of Dubai",
      "state-province": null,
      "domains": [
        "acd.ac.ae"
      ],
      "web_pages": [
        "http://www.acd.ac.ae/"
      ],
      "alpha_two_code": "AE",
      "country": "United Arab Emirates"
    },
    ...

]

```

---

## Deatail View Feature Specs

### Story: Customer requests to see the detail

### Narrative

```
When I press the feed image
I want the app to load detail view
So I can see the detail view
```

#### Scenarios (Acceptance criteria)

```
Given the customer is on feed view
 When the customer requests to see detail for an image
 Then the app should display detail for that image

```

## Use Cases

### Detail view Use Case

#### Data:
- Feed Image

#### Primary course (happy path):
1. System loads data from feed view.
2. System delivers detail.

---

## App Architecture

![Architecture](https://github.com/afsalkp007/ListApp/assets/23147303/917963f0-b703-4c15-b66e-2d084b6f42a2)


## App Composition

![App Composition](https://github.com/afsalkp007/ListApp/assets/23147303/6c0fbc2d-327d-442d-8d83-4d6ea549767a)





