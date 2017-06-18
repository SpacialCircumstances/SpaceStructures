let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions.width = 1200;
project.windowOptions.height = 900;
project.targetOptions.html5.webgl = true;
resolve(project);
