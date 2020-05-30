# Dog Running SA API

The API that allows third-party users to request and modify information about dogs and breeds.

# Overall requirements
- [x] It can CRUD all dogs
- [x] It should display name, breed, age and weight for each dog
- [x] It should display all dogs
- [x] The dogs can be ordered by name, breed, age and weight
- [x] Allows pagination
- [x] Dogs can be filtered
- [x] Efficient redis caching (API currently handles thousands of dogs)
- [x] Reservations just one per dog
- [ ] Summarized data when listing all dogs

# Bugs
- There are probably more bugs that I was not able to encounter and patch due to a obviously limited time, 
but by making a better edge cases covering more bugs would have been patched.

# Improvements 
- More extended test coverage with Rspec (than actual) can lead to identify more bugs 
- Extended redis caching for all models can increase the overall peformance
- Execution of a background job (delayed jobs) for creating news dogs can increase the performance
- Docker would be good for a better a development workflow
- Implement an standard ruby style guide like Rubocop

# Installation instructions
- Install Redis first
- Clone project
- bundle install
- Edit redis.rb for your needs
- redis-server in another window
- rails db:setup
- Run test suite with: rails test
- Go to: localhost:3000 to see magic!

## API
#### Base URL
```
GET https://dogapis.herokuapp.com
```

## Dogs

### `GET /dogs`
Returns a list of all dogs  

```json
[
    {
        "id": 1,
        "name": "Oreo",
        "age": 26,
        "weight": 36,
        "breeds": "miniature pinscher",
        "created_at": "2020-05-09T23:07:08.288Z",
        "updated_at": "2020-05-09T23:07:08.288Z"
    },
    {
        "id": 2,
        "name": "Buddy",
        "age": 99,
        "weight": 68,
        "breeds": "fox terrier",
        "created_at": "2020-05-09T23:07:08.307Z",
        "updated_at": "2020-05-09T23:07:08.307Z"
    }
]
```

### `GET /dogs/1`
Returns a single dog by id number

```json
{
    "id": 1,
    "name": "Oreo",
    "age": 26,
    "weight": 36,
    "breed_list": [
        "miniature pinscher"
    ],
    "reservations": []
}
```

### `GET /dogs?sort=name`
Return dogs ordered. Not only can be ordered by name like in the example but also age, weight and breeds.

### `POST /dogs`
Adds a dog, **new** breeds are added to the breeds database  
Accepted params (*all fields must be present*):
- name (*string*)
- age (*number)
- weight (*number)
- breeds *string, separated by commas*
### Example
```json
{
  "name": "Choco",
  "age": 26,
  "weight": 36,
  "breeds": "miniature pinscher"
}
```

### `PUT /dogs/1`
Updates a dog, **new** breeds are added to the breeds database  
Accepted params (*all fields must be present*):
- name (*string*)
- age (*number)
- weight (*number)
- breeds *string, separated by commas*
### Example
```json
{
  "name": "Choco",
  "age": 26,
  "weight": 36,
  "breeds": "miniature pinscher"
}
```

### `DELETE /dogs/1`
Deletes a dog with an specific dog `:id` number. 

## Breeds

### `GET /breeds`
Returns a list of all unique breeds  

```json
[
  {
      "id": 1,
      "breed": "wheaten terrier"
  },
  {
      "id": 2,
      "breed": "borzoi"
  }
]
```

## Queries
Dogs and breeds can both be queried at their **singular** route

### `GET /dog?q=golden+retriever`
Searches name and breeds for *LIKE* values    

```json
[
  {
      "id": 188,
      "name": "Molly",
      "age": 61,
      "weight": 36,
      "breed_list": [
          "golden retriever"
      ],
      "reservations": []
  }
]
```

### `GET /breed?q=golden`
Searches breed for *LIKE* values  

```json
[
    {
        "id": 24,
        "breed": "golden retriever"
    }
]
```

### Query Pagination
Addition params can be sent for pagination results, works with dogs and breeds
- limit (*default 10*)
- page
### Example
```
GET product?q=golden&limit=25&page=1
```
## Reservations

### `POST /dogs/1/reservations`
Adds a new reservation to an specific dog `:id` number. Only one dog per reservation are allowed, if not it would return anything.
Accepted params:
- reservation_date (string, required)
- notes (string, optional)
### Example
```json
{
  "reservation": {
    "reservation_date": "10/05/2020 03:06:17",
    "notes": "Reserve the Molly for 3 days"
  }
}
```

### `PUT /reservations/1`
Updates a reservation with an specific reservation `:id` number. 
Accepted params:
- reservation_date (string, required)
- notes (string, optional)
### Example
```json
{
  "reservation": {
    "reservation_date": "10/05/2020 03:06:17",
    "notes": "Reserve the Molly for 3 days"
  }
}
```

### `DELETE /reservations/1`
Deletes a reservation with an specific reservation `:id` number. 

### Cheatsheet

| Method  | Endpoint  | Description |
| ----- | ---------- | ------ |
| GET | `/dogs` | Returns an array of `dog`|
| GET | `/dogs/:id` | Returns a dog with the matching `:id`. If the id doesn't exist response will be 404|
| GET | `/dogs?sort=` | Return dogs ordered by name, age, weight and breeds.|
| POST | `/dogs` | Adds a new dog with the correct params. Invalid entries response will be 400|
| PUT | `/dogs/1` | Updates a dog with the correct params.|
| DELETE | `dogs/:id` | Deletes a dog with the matching `id`|
| GET | `/breeds` | Returns an array of `breed`
| GET | `/dog?q=` | Returns an array of searched `dog`. Empty array for no results, also supports pagination `pagination params: limit, page`|
| GET | `/breed?q=` | Returns an array of searched `breed`. Empty array for no results, also supports pagination `pagination params: limit, page`|
| POST | `dogs/:id/reservations` | Adds a new reservation with the matching `id` and the correct params|
| PUT | `reservations/:id` | Updates a reservation with the matching `id` and the correct params, `one reservation per dog`|
| DELETE | `reservations/:id` | Deletes a reservation with the matching `id`|
