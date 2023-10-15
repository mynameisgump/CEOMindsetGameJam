import React, { useRef, useState, useMemo } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { OrbitControls } from '@react-three/drei'
import { CollideEvent, Physics, useBox, usePlane } from '@react-three/cannon'
import { Instances, Stats} from '@react-three/drei'



const Plane = () => {
  const [ref] = usePlane(() => ({ rotation: [-Math.PI / 2, 0, 0] }))
  return (
    <mesh name="Plane" receiveShadow ref={ref}>
      <planeGeometry args={[1000, 1000]} />
      <meshStandardMaterial color="#f0f0f0" />
    </mesh>
  )
}

type CubeProps = {
  position: [x: number, y: number, z: number]
}
const Cube = ({position}: CubeProps) => {
  
  const collisionEvent = (e: CollideEvent) => {
    console.log("collision");
    console.log(e);
  }

  const [ref] = useBox(() => ({ mass: 1, onCollide: collisionEvent, position: position }))
  return (
    <mesh name="Cube" castShadow ref={ref}>
      <boxGeometry />
      <meshStandardMaterial color="orange" />
    </mesh>
  )
}



const ThreeApp = () => {
 return (
    <div style={{width: "100vw", height: "100vh"}}>
        <Canvas>
            <Stats showPanel={0} className="stats"  />
            <ambientLight />
            <pointLight position={[10, 10, 10]} />

            <OrbitControls />
            <Physics>
              <Cube position={[0, 5, 0]} />
              <Plane></Plane>
            </Physics>
        </Canvas>
    </div>
 )
}
  
export default ThreeApp;
