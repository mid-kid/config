; Gimp Plugin to make a proper sprite for pokecrystal from a selection.
; Install this in your gimp scripts folder.

; Usage:
; - Select the sprite you want to "extract" using the selection tool and copy it to your clipboard
; - In the "Script-Fu" menu, go to "Pokecrystal", select "Extract Sprite" (or Backsprite)

; Disclaimer: This script doesn't check your sprite's resolution beyond making sure it's a multiple of 8.
;             It also doesn't work with animations, since it makes sure both sides of the image are exactly as long.

(define (script-fu-make-palette
    image
  )

  (let* (
      (layer (car (gimp-image-get-active-layer image)))
    )

    ; Convert the image to be RGB
    (if (= TRUE (car (gimp-drawable-is-rgb layer))) () (gimp-image-convert-rgb image))

    ; Convert the image to use a color index
    (gimp-image-convert-indexed
      image
      NO-DITHER
      MAKE-PALETTE
      4
      FALSE
      TRUE
      ""
    )

    ; Reverse the colors
    (plug-in-colormap-swap RUN-NONINTERACTIVE image layer 0 3)
    (plug-in-colormap-swap RUN-NONINTERACTIVE image layer 1 2)

    ; Set the first and last colors to pure black and white, respectively
    (let* (
        (colormap (gimp-image-get-colormap image))
        (colormap_len (car colormap))
        (colormap_arr (cadr colormap))
      )
      (aset colormap_arr 0 255)
      (aset colormap_arr 1 255)
      (aset colormap_arr 2 255)
      (aset colormap_arr 9 0)
      (aset colormap_arr 10 0)
      (aset colormap_arr 11 0)
      (gimp-image-set-colormap image colormap_len colormap_arr)
    )
  )
)

(define (script-fu-make-sprite
    image
    backpic
    center
  )

  (let* (
      (layer (car (gimp-image-get-active-layer image)))
      (width 0)
      (height 0)
      (new-width 0)
      (new-height 0)
      (x 0)
      (y 0)
    )

    ; First of all, just crop the selection
    (plug-in-autocrop RUN-NONINTERACTIVE image layer)

    ; Get the current width and height
    (set! width (car (gimp-image-width image)))
    (set! height (car (gimp-image-height image)))

    ; Align them to 8 pixels
    (if (= 0 (modulo width 8)) (set! new-width width) (set! new-width (+ width (- 8 (modulo width 8)))))
    (if (= 0 (modulo height 8)) (set! new-height height) (set! new-height (+ height (- 8 (modulo height 8)))))

    ; Make sure they are the minimum required size
    (if (= backpic 0)
      (begin
        (if (< new-width 40) (set! new-width 40))
        (if (< new-height 40) (set! new-height 40))
      )
      (begin
        (if (< new-width 48) (set! new-width 48))
        (if (< new-height 48) (set! new-height 48))
      )
    )

    ; Set it to the biggest
    (if (> new-width new-height)
      (set! new-height new-width)
      (set! new-width new-height)
    )

    (set! center 1)

    ; Calculate the position of the layer
    (if (= center 1)
      (set! x (- (/ new-width 2) (/ width 2)))

      ; If it isn't centered, start from the left if it's a backpic,
      ; and from the right if it's a frontpic.
      (if (= backpic 0)
        ; Frontpics start from the right side
        (set! x (- new-width width))
      )
    )
    (set! y (- new-height height))

    ; Offset it by two if possible
    (if (= backpic 0)
      (begin
        ; Only offset horizontally if the image isn't being centered
        (if (= center 0)
          (begin
            (if (> x 0) (set! x (- x 1)))
            (if (> x 0) (set! x (- x 1)))
          )
        )
        (if (> y 0) (set! y (- y 1)))
        (if (> y 0) (set! y (- y 1)))
      )

      ; Only offset horizontally if the image isn't being centered
      (if (= center 0)
        (begin
          (if (> new-width (+ x width)) (set! x (+ x 1)))
          (if (> new-width (+ x width)) (set! x (+ x 1)))
        )
      )
    )

    ; Apply that
    (gimp-image-resize image new-height new-width x y)

    ; Resize the layer
    (gimp-layer-resize-to-image-size layer)
    (gimp-layer-flatten layer)

    ; Now, make the palette in a correct format
    (script-fu-make-palette image)
  )
)

(define (script-fu-copy-palette
    source
    dest
  )

  (let* (
      (colormap (gimp-image-get-colormap source))
      (colormap_len (car colormap))
      (colormap_arr (cadr colormap))
    )
    (gimp-image-set-colormap dest colormap_len colormap_arr)
  )
)


(define (script-fu-command-make-palette
    filename
  )

  (let* (
      (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
      (layer (car (gimp-image-get-active-layer image)))
    )
    (script-fu-make-palette image layer)
    (gimp-file-save RUN-NONINTERACTIVE image layer filename filename)
    (gimp-image-delete image)
    (gimp-quit 0)
  )
)

(define (script-fu-command-copy-palette
    filename_src
    filename_dst
  )

  (let* (
      (image_src (car (gimp-file-load RUN-NONINTERACTIVE filename_src filename_src)))
      (image_dst (car (gimp-file-load RUN-NONINTERACTIVE filename_dst filename_dst)))
      (layer_dst (car (gimp-image-get-active-layer image_dst)))
    )
    (script-fu-copy-palette image_src image_dst)
    (gimp-file-save RUN-NONINTERACTIVE image_dst layer_dst filename_dst filename_dst)
    (gimp-image-delete image_src)
    (gimp-image-delete image_dst)
    (gimp-quit 0)
  )
)

(define (script-fu-command-make-sprite
    filename
  )

  (let* (
      (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
      (layer (car (gimp-image-get-active-layer image)))
    )
    (script-fu-make-sprite image 0 0)
    (gimp-file-save RUN-NONINTERACTIVE image layer filename filename)
    (gimp-image-delete image)
    (gimp-quit 0)
  )
)

(define (script-fu-command-make-backsprite
    filename
  )

  (let* (
      (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
      (layer (car (gimp-image-get-active-layer image)))
    )
    (script-fu-make-sprite image 1 0)
    (gimp-file-save RUN-NONINTERACTIVE image layer filename filename)
    (gimp-image-delete image)
    (gimp-quit 0)
  )
)

(define (script-fu-extract-sprite)
  (let*
    ((image (car (gimp-edit-paste-as-new))))

    (if (= TRUE (car (gimp-image-is-valid image)))
      (begin
        (script-fu-make-sprite image 0 0)
        (gimp-display-new image)
      )
      (gimp-message _"There is no image data in the clipboard to paste.")
    )
  )
)

(define (script-fu-extract-backsprite)
  (let*
    ((image (car (gimp-edit-paste-as-new))))

    (if (= TRUE (car (gimp-image-is-valid image)))
      (begin
        (script-fu-make-sprite image 1 0)
        (gimp-display-new image)
      )
      (gimp-message _"There is no image data in the clipboard to paste.")
    )
  )
)

(script-fu-register
  "script-fu-extract-sprite"
  "Extract Sprite"
  "Extracts a sprite from a selection"
  "pfero <ohpee@loves.dicksinhisan.us>"
  "WTFPL"
  "Never ever"
  ""
)
(script-fu-register
  "script-fu-extract-backsprite"
  "Extract Backprite"
  "Extracts a backsprite from a selection"
  "someone <someone@example.com>"
  "WTFPL"
  "Never ever"
  ""
)
(script-fu-register
  "script-fu-make-palette"
  "Make Palette"
  "Convert image into a proper pokemon paletted image"
  "someone <someone@example.com>"
  "WTFPL"
  "Never ever"
  ""
  SF-IMAGE "Image" 0
)
(script-fu-menu-register "script-fu-extract-sprite" "<Image>/Script-Fu/Pokecrystal")
(script-fu-menu-register "script-fu-extract-backsprite" "<Image>/Script-Fu/Pokecrystal")
(script-fu-menu-register "script-fu-make-palette" "<Image>/Script-Fu/Pokecrystal")

(define (script-fu-set-8-grid image) (gimp-image-grid-set-spacing image 8.0 8.0))
(define (script-fu-set-16-grid image) (gimp-image-grid-set-spacing image 16.0 16.0))
(define (script-fu-set-32-grid image) (gimp-image-grid-set-spacing image 32.0 32.0))

(script-fu-register
  "script-fu-set-8-grid"
  "08x08"
  "Enables a 8x8 pixel grid"
  "someone <someone@example.com>"
  "WTFPL"
  "Never ever"
  ""
  SF-IMAGE "Image" 0
)
(script-fu-register
  "script-fu-set-16-grid"
  "16x16"
  "Enables a 16x16 pixel grid"
  "someone <someone@example.com>"
  "WTFPL"
  "Never ever"
  ""
  SF-IMAGE "Image" 0
)
(script-fu-register
  "script-fu-set-32-grid"
  "32x32"
  "Enables a 32x32 pixel grid"
  "someone <someone@example.com>"
  "WTFPL"
  "Never ever"
  ""
  SF-IMAGE "Image" 0
)
(script-fu-menu-register "script-fu-set-8-grid" "<Image>/Script-Fu/Grid")
(script-fu-menu-register "script-fu-set-16-grid" "<Image>/Script-Fu/Grid")
(script-fu-menu-register "script-fu-set-32-grid" "<Image>/Script-Fu/Grid")
