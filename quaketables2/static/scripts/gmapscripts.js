function fitMap(map, points) {
	var bounds = new GLatLngBounds();
	for (var i=0; i< points.length; i++) {
		bounds.extend(points[i]);
	}

	map.setZoom(map.getBoundsZoomLevel(bounds));
	map.setCenter(bounds.getCenter());
}
