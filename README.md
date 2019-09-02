# HRSFCY1Summer3D
First year Hills Road event driven project that takes objects from an SQL database and renders them onscreen. Written in Object Pascal/Delphi using RAD Studio.

## Technical details
Very light documentation on the structure of the program.

### Database
The objects are stored as triangles in a normalised SQL database. The scene is made of many objects, which are made of many triangles. Triangles have one material; materials have many triangles.

Data is loaded in through SQL VCL widgets. When this program was written, stock RAD Studio would not compile projects that used SQL. To compile, you must download sqlite3.dll [here](https://www.sqlite.org/download.html) and use it to replace sqlite3.dll in RAD Studio's installation folder. Without this, the compiled program will not be able to read from the database. Hopefully this will have changed in the near future.

### Rendering
Once the objects have been loaded into memory, they are broken down into triangles (primitives) and have their object's position, scale and rotation applied to them. The camera's position and rotation is then applied, but inverted. They are then sorted by their mean z coordinate and drawn back to front onto the canvas using either a simple orthographic or perspective projection.

### Explanations of structural quirks
* All faces are stored as triangles to make the database normalisable.
* The use of materials which only have colour data, instead of just directly assigning them RGB values, is a relic of an early idea to adjust the shading based on the angle of the plane (to approximate simple shadowless sun lighting). However, this was abandoned due to time constraints.

## Known issues
* The canvas will completely or partially clear when the subwindow is resized or partially moved offscreen. This is an issue caused by VCL and the specific canvas widget. It could possibly be fixed by finding the events that are triggered by this and using them to call the render method.
* The borders of the screen are not overwritten. There is no way to clear the specific VCl paintbox widget. Therefore, a white rectangle is drawn over the whole screen. However, it is not perfectly sized.
* Triangles can pop into and out of visibility when they shouldn't. This is a limitation of both the painter's algorithm and the sorting method used. In an ideal scenario, a Z buffer would have been used. However, there was no way to set individual pixels easily, and creating rectangles one pixel wide had large performance penalties.
