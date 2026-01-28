/// Step Event of obj_display_manager

// 1. Get the current size of the game window
var _current_width = window_get_width();
var _current_height = window_get_height();

// 2. Check if the window size is different from the application surface
// (This ensures we only run the expensive resize code when actually needed)
if (_current_width != surface_get_width(application_surface) || _current_height != surface_get_height(application_surface)) {
    
    // --- UPDATE RESOLUTION ---
    
    // Resize the "Application Surface" (The canvas the game is drawn on)
    // This ensures your pixels remain 1:1 and crisp, preventing blurring/stretching.
    surface_resize(application_surface, _current_width, _current_height);
    
    // --- UPDATE CAMERA (What we see) ---
    
    // Get the current camera used by View 0
    var _cam = view_camera[0];
	var _zoom = 0.25; // 0.25 means the camera is 1/4th the size of the window (4x zoom)
	camera_set_view_size(_cam, _current_width * _zoom, _current_height * _zoom);
    
    // Resize the camera view to match the new window dimensions.
    // This makes the camera show more/less of the room.
    camera_set_view_size(_cam, _current_width, _current_height);
    
    // Resize the viewport port (The area on screen the camera draws to)
    view_wport[0] = _current_width;
    view_hport[0] = _current_height;
    
    // --- UPDATE GUI (Optional) ---
    
    // If you want your UI layer to match the window resolution:
    display_set_gui_size(_current_width, _current_height);
}