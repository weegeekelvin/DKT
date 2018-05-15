﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public enum ButtonType { LOADSCENE_ON_ACTION, TELEPORT_ON_ACTION, DISPLAY_UI_ON_GAZE, DISPLAY_UI_ON_ACTION, QUIT_ON_ACTION, PLAY_PAUSE_VIDEO };

public class MasterButton : MonoBehaviour, IInteractiveObject {

    [TextArea]
    public string scriptNotes = "*DO NOT EDIT*\nThe fields:\n\tProgress Bar\n\tOverlay UI\nwill only display if they are not null.\n\nThe remaining fields will need to be filled based on the button function.\nLOADSCENE: sceneIndex\nTELEPORT: Teleoport To\nDISPLAY UI: overlay UI\n";

    [SerializeField] private ButtonType buttonAction;
    [SerializeField] private float gazeTimer = 2.0f;
    private float gazeTimerToEdit;
    [SerializeField] private int sceneIndex;
    [SerializeField] private Image progressBar;
    [SerializeField] private Transform teleportTo;
    [SerializeField] private GameObject overlayUI;
    private float barProgress = 0.0f;
    private float barSpeed = 50.0f;

    private AudioSource onHoverSound;

    [SerializeField] Transform player;

    private VideoController vc = null;

    private bool gazingAt = false;



    public void Action()
    {
        switch(buttonAction)
        {
            case ButtonType.LOADSCENE_ON_ACTION:
                SceneToLoad.SceneIndexToLoad = sceneIndex;
                SceneManager.LoadScene(1);
                break;
            case ButtonType.TELEPORT_ON_ACTION:
                player.position = teleportTo.position;
                break;
            case ButtonType.DISPLAY_UI_ON_GAZE:
                break;
            case ButtonType.QUIT_ON_ACTION:
                Application.Quit();
                break;
            case ButtonType.PLAY_PAUSE_VIDEO:
                if (vc != null) { vc.PlayAndPause(); }
                break;
        }
    }

    public void GazeEnter()
    {
        gazingAt = true;
        print("Gazing");

        if (buttonAction == ButtonType.DISPLAY_UI_ON_GAZE && overlayUI != null)
        {
            overlayUI.SetActive(true);
        }
        if (onHoverSound != null)
        {
            onHoverSound.Play();
        }
        
    }

    public void GazeExit()
    {
        gazingAt = false;
        barProgress = 0.0f;
        UpdateBarProgress();
        gazeTimerToEdit = gazeTimer;
        if (buttonAction == ButtonType.DISPLAY_UI_ON_GAZE && overlayUI != null)
        {
            overlayUI.SetActive(false);
        }

        if(buttonAction == ButtonType.PLAY_PAUSE_VIDEO && vc != null)
        {
            vc.UnpressButton();
        }
    }

    public void GazeTimer()
    {
        if (gazingAt)
        {
            gazeTimerToEdit -= Time.deltaTime;

            UpdateBarProgress();

            if (gazeTimerToEdit <= 0)
            {
                Action();
            }
        }
    }

    public void UpdateBarProgress()
    {
        
        if (barProgress < 100)
        {
            
            barProgress += barSpeed * Time.deltaTime;
        }

        if (progressBar != null) { progressBar.fillAmount = barProgress / 100; }
       
    }

    private float GetProgressBarDuration()
    {
        return 100 / gazeTimer;
    }

    IEnumerator LoadNewScene()
    {
        SceneManager.LoadScene(sceneIndex);
        // Start an asynchronous operation to load the scene that was passed to the LoadNewScene coroutine.
        AsyncOperation async = SceneManager.LoadSceneAsync(sceneIndex);

        // While the asynchronous operation to load the new scene is not yet complete, continue waiting until it's done.
        while (!async.isDone)
        {
            yield return null;
        }

    }

    // Use this for initialization
    void Start () {
        
        player = GameObject.Find("PlayerNew").GetComponent<Transform>();
        gazeTimerToEdit = gazeTimer;
        UpdateBarProgress();
        if(buttonAction == ButtonType.DISPLAY_UI_ON_GAZE && overlayUI != null)
        {
            overlayUI.SetActive(false);
        }
        
        onHoverSound = GetComponent<AudioSource>();
        vc = GetComponent<VideoController>();
        barSpeed = GetProgressBarDuration();
    }
	
	// Update is called once per frame
	void Update () {

        GazeTimer();
        
	}

}