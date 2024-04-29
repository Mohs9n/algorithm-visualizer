package main

import "core:fmt"
import "core:os"
import "core:time"
import sdl "vendor:sdl2"

bubble :: proc() {
	for i in 0 ..< len(Algo.Data) {
		for j in 0 ..< len(Algo.Data) {
			if Algo.Data[j] > Algo.Data[i] {
				temp := Algo.Data[j]
				Algo.Data[j] = Algo.Data[i]
				Algo.Data[i] = temp
			}
			drawBubble(i32(j))
			// time.sleep(1)
		}
	}
	Algo.Done = true
}

drawBubble :: proc(r: i32) {
	prepareScene()
	drawBorder(5, 0, 0, 200 * 5 + 5, 451)
	sdl.SetRenderDrawColor(app.renderer, 255, 255, 255, 255)
	rect := sdl.Rect{0, 0, 0, 0}
	x: i32 = 6
	// fmt.println(Algo.Data)
	for i in Algo.Data {
		// fmt.println(i)
		rect = {x, 450, 5, -i * 2}
		if i == r do sdl.SetRenderDrawColor(app.renderer, 255, 0, 0, 255)
		sdl.RenderFillRect(app.renderer, &rect)
		if i == r do sdl.SetRenderDrawColor(app.renderer, 255, 255, 255, 255)
		x += 5
	}
	// uirender(&state.mu_ctx,app.renderer)
	if input(&state.mu_ctx) do os.exit(1)
	sdl.RenderPresent(app.renderer)
}
