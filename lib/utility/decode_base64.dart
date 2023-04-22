import 'dart:convert';
import 'dart:typed_data';

Uint8List decodeBase64(String encoded) {
  String dataPart;
  if (encoded.startsWith('data:image/')) {
    // RFC-2397
    dataPart = encoded.split(',').last;
  } else {
    dataPart = encoded;
  }
  return base64Decode(base64.normalize(dataPart));
}
