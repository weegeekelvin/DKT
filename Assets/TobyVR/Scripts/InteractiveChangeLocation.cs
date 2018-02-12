﻿using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractiveChangeLocation : MonoBehaviour, IInteractiveObject
{

    
    [SerializeField]private float gazeTimer = 1.0f; //Seconds taken to activate interactive event
    private bool gazingAt = false; //flag 

    [SerializeField] private Transform endWaypoint;
    
    private Vector3 startLocation; //current location
    private Vector3 endLocation; //goal location

    private Transform player;
    
    private float speed = 10.0f;

    void Start()
    {
        player = GameObject.Find("Player").GetComponent<Transform>();
        
        endLocation = endWaypoint.position;
        
    }
    void Update()
    {
        GazeTimer();
    }

    public void Action()
    {
        player.position = endLocation;
    }

    public void GazeEnter()
    {
        gazingAt = true;
    }

    public void GazeExit()
    {
        gazeTimer = 1.0f;
        gazingAt = false;

    }

    public void GazeTimer()
    {
        if (gazingAt)
        {
            gazeTimer -= Time.deltaTime;

            if (gazeTimer <= 0)
            {
                Action();
            }
        }
    }
}