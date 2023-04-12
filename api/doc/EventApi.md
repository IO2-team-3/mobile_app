# openapi.api.EventApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://yourbackenhosting.edu.pl*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addEvent**](EventApi.md#addevent) | **POST** /events | Add new event
[**cancelEvent**](EventApi.md#cancelevent) | **DELETE** /events/{id} | Cancel event
[**getByCategory**](EventApi.md#getbycategory) | **GET** /events/getByCategory | Return list of all events in category
[**getEventById**](EventApi.md#geteventbyid) | **GET** /events/{id} | Find event by ID
[**getEvents**](EventApi.md#getevents) | **GET** /events | Return list of all events
[**getMyEvents**](EventApi.md#getmyevents) | **GET** /events/my | Return list of events made by organizer, according to session
[**patchEvent**](EventApi.md#patchevent) | **PATCH** /events/{id} | patch existing event


# **addEvent**
> Event addEvent(eventForm)

Add new event

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: token
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final EventForm eventForm = ; // EventForm | Add event

try {
    final response = api.addEvent(eventForm);
    print(response);
} catch on DioError (e) {
    print('Exception when calling EventApi->addEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventForm** | [**EventForm**](EventForm.md)| Add event | [optional] 

### Return type

[**Event**](Event.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelEvent**
> cancelEvent(id)

Cancel event

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: token
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final String id = id_example; // String | id of Event

try {
    api.cancelEvent(id);
} catch on DioError (e) {
    print('Exception when calling EventApi->cancelEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id of Event | 

### Return type

void (empty response body)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByCategory**
> BuiltList<Event> getByCategory(categoryId)

Return list of all events in category

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final int categoryId = 789; // int | ID of category

try {
    final response = api.getByCategory(categoryId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling EventApi->getByCategory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**| ID of category | 

### Return type

[**BuiltList&lt;Event&gt;**](Event.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEventById**
> EventWithPlaces getEventById(id)

Find event by ID

Returns a single event

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();
final int id = 789; // int | ID of event to return

try {
    final response = api.getEventById(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling EventApi->getEventById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| ID of event to return | 

### Return type

[**EventWithPlaces**](EventWithPlaces.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEvents**
> BuiltList<Event> getEvents()

Return list of all events

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventApi();

try {
    final response = api.getEvents();
    print(response);
} catch on DioError (e) {
    print('Exception when calling EventApi->getEvents: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Event&gt;**](Event.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyEvents**
> BuiltList<Event> getMyEvents()

Return list of events made by organizer, according to session

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: token
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();

try {
    final response = api.getMyEvents();
    print(response);
} catch on DioError (e) {
    print('Exception when calling EventApi->getMyEvents: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Event&gt;**](Event.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchEvent**
> patchEvent(id, eventPatch)

patch existing event

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: token
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKeyPrefix = 'Bearer';

final api = Openapi().getEventApi();
final String id = id_example; // String | id of Event
final EventPatch eventPatch = ; // EventPatch | Update an existent user in the store

try {
    api.patchEvent(id, eventPatch);
} catch on DioError (e) {
    print('Exception when calling EventApi->patchEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| id of Event | 
 **eventPatch** | [**EventPatch**](EventPatch.md)| Update an existent user in the store | [optional] 

### Return type

void (empty response body)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

