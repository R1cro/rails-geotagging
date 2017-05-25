## JSON API Documentation

**Search Dynamic Objects**
----
  Returns JSON data about objects within requested area.

* **URL**

  `/api/dynamic_objects/search`

* **Method:**

  `GET`

*  **URL Params**

   **Required:**
    Center point of search area (latitude and longitude):
   `center[lat]=number`
   `center[lng]=number`
   Search radius (in kilometers, could be float)
   `radius=number`

* **Data Params**

  None

* **Success Response:**

  * **Code:** 200 <br />
    **Content:**
    All objects within requested area
    ```
    [
      {
        "id": 5,
        "type_id": 2,
        "name": "Great piece of text",
        "description": "great piece of short information",
        "lat": 53.9116664,
        "lng": 27.5651747,
        "bearing": "179.999999958901"
      }
    ]
    ```

* **Error Response:**

  * **Code:** 500 Internal Server Error <br />

  OR

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You are unauthorized to make this request." }`

* **Sample Call:**
`curl -g http://localhost:3000/api/dynamic_objects/search\?center\[lat\]\=53.9116664\&center\[lng\]\=27.5651747\&radius\=3`
