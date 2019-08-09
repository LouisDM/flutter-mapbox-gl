package com.mapbox.mapboxgl;

import com.mapbox.mapboxsdk.plugins.annotation.Circle;

interface OnCircleDragAssembleListener {
    void onCircleDragStart(Circle circle);

    void onCircleDrag(Circle circle);

    void onCircleDragEnd(Circle circle);
}
