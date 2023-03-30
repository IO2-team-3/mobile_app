# openapi.api.CategoriesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://pw.edu.pl/api/v3*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addCategories**](CategoriesApi.md#addcategories) | **POST** /categories | Create new category
[**getCategories**](CategoriesApi.md#getcategories) | **GET** /categories | Return list of all categories


# **addCategories**
> Category addCategories(categoryName)

Create new category

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: token
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('token').apiKeyPrefix = 'Bearer';

final api = Openapi().getCategoriesApi();
final String categoryName = categoryName_example; // String | name of category

try {
    final response = api.addCategories(categoryName);
    print(response);
} catch on DioError (e) {
    print('Exception when calling CategoriesApi->addCategories: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryName** | **String**| name of category | 

### Return type

[**Category**](Category.md)

### Authorization

[token](../README.md#token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCategories**
> BuiltList<Category> getCategories()

Return list of all categories

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoriesApi();

try {
    final response = api.getCategories();
    print(response);
} catch on DioError (e) {
    print('Exception when calling CategoriesApi->getCategories: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Category&gt;**](Category.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

