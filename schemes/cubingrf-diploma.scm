(
    define (cubingrf-diploma filename place discipline)
    (let*
        (
            (image
                (
                    car (gimp-file-load RUN-NONINTERACTIVE filename filename)
                )
            )
            (drawable 0)
            (layer 0)
            (font 0)
            (output-name (string-append "diplomas/" discipline "_" place ".png"))
        )
        (set! layer
            (
                car (gimp-image-get-layer-by-name image "discipline")
            )
        )
        (set! font (car (gimp-text-layer-get-font layer)))
        (gimp-text-layer-set-text layer discipline)
        (gimp-text-layer-set-font-size layer 200.0 0)
        (gimp-text-layer-set-font layer font)
        (set! layer
            (
                car (gimp-image-get-layer-by-name image discipline)
            )
        )
        (gimp-item-set-visible layer TRUE)
        (set! layer
            (
                car (gimp-image-get-layer-by-name image "place")
            )
        )
        (set! font (car (gimp-text-layer-get-font layer)))
        (gimp-text-layer-set-text layer place)
        (gimp-text-layer-set-font-size layer 160.0 0)
        (gimp-text-layer-set-font layer font)
        (set! drawable
            (
                car (gimp-image-merge-visible-layers image 0)
            )
        )
        (file-png-save-defaults
            RUN-NONINTERACTIVE
            image
            drawable
            output-name
            output-name
        )
    )
)
