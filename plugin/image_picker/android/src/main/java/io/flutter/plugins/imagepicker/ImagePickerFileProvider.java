package io.flutter.plugins.imagepicker;

/**
 * Providing a custom {@code FileProvider} prevents manifest {@code <provider>} name collisions.
 *
 * <p>See https://developer.android.com/guide/topics/manifest/provider-element.html for details.
 */
public class ImagePickerFileProvider extends FileProvider {}
