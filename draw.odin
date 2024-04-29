package main

import sdl "vendor:sdl2"
import sdlF "vendor:sdl2/ttf"

drawList :: proc() {
	sdl.SetRenderDrawColor(app.renderer, 255, 255, 255, 255)
}

drawBorder :: proc(thickness, x, y, w, h: i32) {
	sdl.SetRenderDrawColor(app.renderer, 255, 200, 150, 255)
	rect := sdl.Rect{0, 0, w, h}
	sdl.RenderDrawRect(app.renderer, &rect)
	for i in 0 ..= thickness {
		rect.x = i
		rect.y = i
		sdl.RenderDrawRect(app.renderer, &rect)
	}
}

drawText :: proc(x, y: i32, font: ^sdlF.Font, text: cstring, color: sdl.Color) {
	surfaceMessege: ^sdl.Surface = sdlF.RenderText_Solid(font, text, color)
	defer sdl.FreeSurface(surfaceMessege)

	texture: ^sdl.Texture = sdl.CreateTextureFromSurface(app.renderer, surfaceMessege)
	defer sdl.DestroyTexture(texture)

	textRect: sdl.Rect = {x, y, surfaceMessege.w, surfaceMessege.h}
	sdl.RenderCopy(app.renderer, texture, nil, &textRect)
}

prepareScene :: proc() {
	sdl.SetRenderDrawColor(app.renderer, state.bg.r, state.bg.g, state.bg.b, state.bg.a)
	sdl.RenderClear(app.renderer)
}

presentScene :: proc() {
	sdl.RenderPresent(app.renderer)
}
