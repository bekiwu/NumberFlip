DEVICE_HEIGHT = 1334
DEVICE_WIDTH = 750

STAGE_NUM = 3

Framer.Defaults.Animation.curve = 'spring(200, 20, 0)'
Framer.Defaults.Layer.backgroundColor = 'transparent'

count = (start = 0, end, layer, delayVal = 0.01) ->
	current = start
	layer.html = current
	
	dist = end - start
	isIncrease = if dist > 0 then true else false
	
# 	if isIncrease
	if current >= end
		return
	else
		Utils.delay delayVal, ->
			count(current, end, layer, delayVal)
	if dist > 1000
		current += 78
	else if dist > 500
		current += 23
	else if dist > 200
		current += 7
	else
		current += 3
				
# 	else		
# 		if current <= end
# 			return
# 		else 
# 			Utils.delay delayVal, ->
# 				count(current, end, layer, delayVal)
# 		current = current - 10
							

bg = new BackgroundLayer
# 	image: 'images/bg.png'
	backgroundColor: '#fff'


stages = []

container = new Layer
	height: DEVICE_HEIGHT
	width: STAGE_NUM * DEVICE_WIDTH
	
container.draggable.enabled = true
container.draggable.speedY = 0

for i in [0..STAGE_NUM - 1]
	stage = new Layer
		width: DEVICE_WIDTH
		height: DEVICE_HEIGHT
		x: i * DEVICE_WIDTH
		superLayer: container
		
	stages.push(stage)
		


stage1 = stages[0]
stage2 = stages[1]
stage3 = stages[2]

stage1.style = stage2.style = stage3.style =
	fontSize: '56px'
	color: '#555'
	lineHeight: '84px'

stage1Text1 = new Layer
	superLayer: stage1
	color: '#00a32e'
	width: 300
	x: 94
	y: 330
	
stage1Text2 = new Layer
	superLayer: stage1
	width: 348
	height: 256
	x: 94
	y: 330 + stage1Text1.height

stage1Text1.html = '2014'
stage1Text2.html = '是你和朋友们<br>点赞的一年'

stage2Text1 = new Layer
	superLayer: stage2
	width: 300
	x: 94
	y: 330
	
stage2Text2 = new Layer
	superLayer: stage2
	width: 300
	height: 180
	color: '#eea800'
	x: 94
	y: 330 + stage2Text1.height
	
stage2Text3 = new Layer
	superLayer: stage2
	width: 300
	x: 94 + stage2Text2.width
	maxY: stage2Text2.maxY
	
stage2Text2.style.fontSize = '180px'
stage2Text2.style.lineHeight = '180px'
stage2Text2.style.fontWeight = '100'

stage2Text1.html = '你送出了'
stage2Text2.html = '0'
stage2Text3.html = '个赞'

stage3Text1 = new Layer
	superLayer: stage3
	width: 300
	x: 94
	y: 330
	
stage3Text2 = new Layer
	superLayer: stage3
	width: 400
	height: 180
	color: '#007bee'
	x: 94
	y: 330 + stage3Text1.height
	
stage3Text3 = new Layer
	superLayer: stage3
	width: 300
	x: 94 + stage3Text2.width
	maxY: stage3Text2.maxY
	
stage3Text2.style.fontSize = '180px'
stage3Text2.style.lineHeight = '180px'
stage3Text2.style.fontWeight = '100'

stage3Text1.html = '你收获了'
stage3Text2.html = '0'
stage3Text3.html = '个赞'


containerMove = (x) ->
	container.animate
		properties:
			x: x

container.on Events.TouchStart, ->
	container.dragStartX = container.x

container.on Events.DragEnd, ->
# 	print container.draggable.calculateVelocity()
	
	# Stage 1 to Stage 2
	if container.x < -50
		containerMove(-DEVICE_WIDTH)
		count(eval(stage2Text2.html), 371, stage2Text2)
	
	# Stage 2 to Stage 3
	if container.x < -50 - DEVICE_WIDTH
		containerMove(-DEVICE_WIDTH * 2)
		count(eval(stage3Text2.html), 2678, stage3Text2)
		
	if container.x > 0
		containerMove(0)
		