﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractiveEnableMoreUI : MonoBehaviour, IInteractiveObject
{
     private float gazeTimer = 1.0f; //Seconds taken to activate interactive event
    [SerializeField] private GameObject[] ui = new GameObject[0];

    private bool gazingAt = false; //flag 

    public void Action()
    {
        EnableElements();
        gameObject.SetActive(false);
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

            Action();
        }
    }

    // Use this for initialization
    void Awake()
    {

        for (int i = 0; i < ui.Length; i++)
        {
            ui[i].SetActive(false);
        }
    }
    void Start()
    {
        gazeTimer = GetComponent<GazeData>().getGazeTimer;
    }

    void EnableElements()
    {
        for (int i = 0; i < ui.Length; i++)
        {
            ui[i].SetActive(true);
        }
    }
}