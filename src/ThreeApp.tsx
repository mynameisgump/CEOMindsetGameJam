import React, { useRef, useState, useEffect } from 'react'
import { Canvas } from '@react-three/fiber'
import { OrbitControls } from '@react-three/drei'
import { Stats, Environment} from '@react-three/drei'
import { Physics, RigidBody, InstancedRigidBodies } from '@react-three/rapier'
import { Box } from '@react-three/drei'
import GrinderSep from './GrinderSep'
import { SphereGeometry } from 'three'





const Floor = () => {
  console.log("floor test")
  return (
    <RigidBody type="fixed" colliders="cuboid" name="floor">
      <Box
        position={[0, -12.55 - 5, 0]}
        scale={[200, 10, 200]}
        rotation={[0, 0, 0]}
        receiveShadow
      >
        <meshStandardMaterial color={"red"}/>
      </Box>
    </RigidBody>
  );
};


const Meat = () => {
  
  return (
    <RigidBody colliders="hull" name="Meat">
      <mesh position={[0,5,0]} castShadow={true}>
        <sphereGeometry args={[1, 32, 32]} />
        <meshStandardMaterial color="hotpink" />
      </mesh>
    </RigidBody>
  )
}

const createBody = (): InstancedRigidBodyProps => ({
  key: Math.random(),
  position: [Math.random() * 20, Math.random() * 20, Math.random() * 20],
  rotation: [
    Math.random() * Math.PI * 2,
    Math.random() * Math.PI * 2,
    Math.random() * Math.PI * 2
  ],
  scale: [0.5 + Math.random(), 0.5 + Math.random(), 0.5 + Math.random()]
});

const MAX_COUNT = 2;

const ThreeApp = () => {
  const sphereGeo = new SphereGeometry(1, 32, 32);
  const api = useRef([]);

  const [bodies, setBodies] = useState<any[]>(() =>
    Array.from({
      length: 100
    }).map(() => createBody())
  );

  const ref = useRef<any>(null);
  

  useEffect(() => {
    if (ref.current) {
      for (let i = 0; i < MAX_COUNT; i++) {
        ref.current!.setColorAt(i, new Color(Math.random() * 0xffffff));
      }
      ref.current!.instanceColor!.needsUpdate = true;
    }
  }, []);

 return (
    <div style={{width: "100vw", height: "100vh"}}>
        <Canvas shadows dpr={1}>
            <Stats showPanel={0} className="stats"  />
            {/* <ambientLight /> */}
            <pointLight position={[10, 10, 10]} />

            <OrbitControls />

            <directionalLight
                castShadow
                position={[10, 10, 10]}
                shadow-camera-bottom={-40}
                shadow-camera-top={40}
                shadow-camera-left={-40}
                shadow-camera-right={40}
                shadow-mapSize-width={1024}
                shadow-bias={-0.0001}
              />
            <Environment preset="apartment" />

            <Physics debug gravity={[0, -1, 0]} >
              <Meat></Meat>
              <Floor></Floor>
              <GrinderSep></GrinderSep>
              <InstancedRigidBodies instances={bodies} ref={api} colliders="hull">
                <instancedMesh
                  ref={ref}
                  castShadow
                  args={[sphereGeo, undefined, MAX_COUNT]}
                  count={bodies.length}
                  onClick={(evt) => {
                    api.current![evt.instanceId!].applyTorqueImpulse(
                      {
                        x: 0,
                        y: 50,
                        z: 0
                      },
                      true
                    );
                  }}
                >
                  <meshPhysicalMaterial />
                </instancedMesh>
              </InstancedRigidBodies>
            </Physics>
            
        </Canvas>
    </div>
 )
}
  
export default ThreeApp;
