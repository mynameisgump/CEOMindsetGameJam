import React, { useRef, useState, useMemo } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { OrbitControls } from '@react-three/drei'
import { Physics, useBox, usePlane } from '@react-three/cannon'
import { Instances } from '@react-three/drei'


type CubeProps = {
  position: [x: number, y: number, z: number]
}
const Cube = ({position}: CubeProps) => {
  const [ref] = useBox(() => ({ mass: 1, position: position }))
  return (
    <mesh castShadow ref={ref}>
      <boxGeometry />
      <meshStandardMaterial color="orange" />
    </mesh>
  )
}



const ThreeApp = () => {
 return (
    <div style={{width: "100vw", height: "100vh"}}>
        <Canvas>
            <ambientLight />
            <pointLight position={[10, 10, 10]} />

            <OrbitControls />
            <Physics>
              <Cube position={[0, 5, 0]} />

            </Physics>
        </Canvas>
    </div>
 )
}
  
export default ThreeApp;
