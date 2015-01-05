# var canvas = document.getElementById('myCanvas');
#       var context = canvas.getContext('2d');
#       var imageObj = new Image();
#       var scaleX = 1;
#       var scaleY = 1;

#       imageObj.onload = function() {
#         console.log(imageObj.width);
#         var tempWidth = scaleX * imageObj.width;
#         var tempHeight = scaleY * imageObj.height;
#         var tempCanvas = document.createElement("canvas"),
#         tCtx = tempCanvas.getContext("2d");
#         tempCanvas.width = tempWidth;
#         tempCanvas.height = tempHeight;
#         tCtx.drawImage(imageObj, 0, 0, imageObj.width, imageObj.height, 0, 0, tempWidth, tempHeight);
        
#         console.log(imageObj);
#         console.log(context);
#         var pattern = context.createPattern(tempCanvas, 'repeat');
#         context.rect(0, 0, canvas.width, canvas.height);
#         context.beginPath();
#         context.moveTo(170, 80);
#         context.bezierCurveTo(130, 100, 130, 150, 230, 150);
#         context.bezierCurveTo(250, 180, 320, 180, 340, 150);
#         context.bezierCurveTo(420, 150, 420, 120, 390, 100);
#         context.bezierCurveTo(430, 40, 370, 30, 340, 50);
#         context.bezierCurveTo(320, 5, 250, 20, 250, 50);
#         context.bezierCurveTo(200, 5, 150, 20, 170, 80);
#         context.fillStyle = pattern;
#         context.rotate(0.3);
#         context.fill();
#       };
#       imageObj.src = 'http://www.html5canvastutorials.com/demos/assets/wood-pattern.png';

createTexturedPoly = (poly, props) ->
    img = PIXI.TextureCache[props.src].baseTexture.source
    canvas = document.createElement 'canvas'
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    context = canvas.getContext '2d'

    # if the texture should be scaled then I'll change the img accordingly (temporary)
    if (props.scaleX isnt 1 or props.scaleY isnt 1)
        scaledCanvas = document.createElement('canvas')
        scaledContext = scaledCanvas.getContext('2d')
        scaledWidth = props.scaleX * img.width
        scaledHeight = props.scaleY * img.height
        scaledCanvas.width = scaledWidth
        scaledCanvas.height = scaledHeight
        scaledContext.drawImage(img, 0, 0, img.width, img.height, 0, 0, scaledWidth, scaledHeight)
        img = scaledCanvas

    pattern = context.createPattern(img, 'repeat')
    context.beginPath()
    context.moveTo(poly[0].x, poly[0].y)
    
    for point in poly
        context.lineTo(point.x, point.y)
    context.fillStyle = pattern;

    if props.rotation isnt 0
        context.rotate(props.rotation * 0.0174532925)

    context.fill()
    new PIXI.Sprite(PIXI.Texture.fromCanvas(canvas))

renderer = null
stage = null

 
textureProps0 =
    scaleX:.1
    scaleY:.1
    rotation:90
    src:'grass.jpg'

textureProps1 =
    scaleX:1
    scaleY:1
    rotation:90
    src:'wood-pattern.png'

textureProps2 =
    scaleX:0.7
    scaleY:0.4
    rotation:15
    src:'rock1.jpg'

textureProps3 =
    scaleX:3
    scaleY:3
    rotation:90
    src:'rock2.jpg'

window.onload = ->
    renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight)
    stage = new PIXI.Stage(0xff0000)
    document.body.appendChild(renderer.view)
    assetsToLoad = ['wood-pattern.png', 'rock1.jpg', 'rock2.jpg', 'grass.jpg']
    loader = new PIXI.AssetLoader(assetsToLoad)
    loader.onComplete = ->
        sprite1 = createTexturedPoly([new PIXI.Point(0,0),new PIXI.Point(window.innerWidth,0),new PIXI.Point(window.innerWidth,window.innerHeight),new PIXI.Point(0,window.innerHeight/2)], textureProps0)
        stage.addChild sprite1
        sprite2 = createTexturedPoly([new PIXI.Point(60,60),new PIXI.Point(10,0),new PIXI.Point(850,50),new PIXI.Point(100,800),new PIXI.Point(50,80),new PIXI.Point(0,100)], textureProps1)
        stage.addChild sprite2
        sprite3 = createTexturedPoly([new PIXI.Point(60,60),new PIXI.Point(10,0),new PIXI.Point(850,50),new PIXI.Point(100,800),new PIXI.Point(50,80),new PIXI.Point(0,100)], textureProps2)
        sprite3.position = x:100,y:100
        stage.addChild sprite3
        renderer.render(stage)
    loader.load()
    console.log loader
