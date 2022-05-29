(
    define (cubingrf-badge filename name class)
    (let*
        (
            (image
                (
                    car (gimp-file-load RUN-NONINTERACTIVE filename filename)
                )
            )
            (drawable 0)
            (layer 0)
        )
        (set! layer
            (
                car (gimp-image-get-layer-by-name image "name")
            )
        )
        (gimp-text-layer-set-text layer name)
        (gimp-text-layer-set-font-size layer 120.0 0)
        (set! layer
            (
                car (gimp-image-get-layer-by-name image "class")
            )
        )
        (gimp-text-layer-set-text layer class)
        (gimp-text-layer-set-font-size layer 98.0 0)
        (set! drawable
            (
                car (gimp-image-merge-visible-layers image 0)
            )
        )
        (file-png-save-defaults
            RUN-NONINTERACTIVE
            image
            drawable
            (string-append "badges/" name " " class ".png")
            (string-append "badges/" name " " class ".png")
        )
    )
)
